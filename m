Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265034AbUELM01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265034AbUELM01 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 08:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265036AbUELM01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 08:26:27 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:7074 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S265034AbUELM0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 08:26:25 -0400
Message-ID: <40A217EF.2000007@blueyonder.co.uk>
Date: Wed, 12 May 2004 13:26:23 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: 2.6.6-mm1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 May 2004 12:26:27.0947 (UTC) FILETIME=[592B5BB0:01C4381C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
 > Is this repeatable? A null-pointer deref at
 > locks_alloc_lock+0x1/0x20 seems not possible.
 >
 > Please send the output of
 >
 > nm -n vmlinux | grep -5 locks_alloc_lock
I only tried booting the kernel once, shall have another go later and 
gather some other traces if it fails.

barrabas:/usr/src/linux-2.6.6-mm1 # nm -n vmlinux | grep -5 locks_alloc_lock
c015b4e0 T sys_poll
c015b730 t wait_for_partner
c015b770 t wake_up_partner
c015b7a0 t fifo_open
c015ba56 t .text.lock.fifo
c015ba80 t locks_alloc_lock
c015baa0 T locks_init_lock
c015bb20 t init_once
c015bb40 T locks_copy_lock
c015bbb0 t flock_make_lock
c015bc50 t assign_type

Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

