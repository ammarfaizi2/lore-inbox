Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbUANSxQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 13:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264318AbUANSxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 13:53:16 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:52376 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264376AbUANSxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 13:53:13 -0500
Message-ID: <40058F99.2030207@colorfullife.com>
Date: Wed, 14 Jan 2004 19:51:05 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH, BACKPORT] end-of-stack detection
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The oops dump code detects the end of the kernel stack with
    (addr & (THREAD_SIZE-1))
This fails if the kernel stack is not 32-bit aligned. This can happen if 
an APM bios call is interrupted and then causes an oops. The result is 
an unreadable and incomplete oops dump. 2.6 contains a similar fix.

Marcelo, could you apply the patch to your tree?

--
    Manfred

