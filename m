Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVCMSRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVCMSRD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 13:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVCMSRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 13:17:03 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:16257 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261406AbVCMSQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 13:16:59 -0500
Message-ID: <423492EF.61853477@tv-sign.ru>
Date: Sun, 13 Mar 2005 22:22:23 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roland McGrath <roland@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] x86-64 kprobes: handle %RIP-relative addressing mode
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath wrote:
>
> +	* This basically replicates __vmalloc, except that it uses a
> +	* range of addresses starting at MODULE_END.  This also

Could you look at these patches:

[PATCH 1/5] vmalloc: introduce __vmalloc_area() function
http://marc.theaimsgroup.com/?l=linux-kernel&m=111013183331326

[PATCH 5/5] vmalloc: use list of pages instead of array in vm_struct
http://marc.theaimsgroup.com/?l=linux-kernel&m=111013224029332

There are in mm3 now. Note that the second one will conflict with
your patch.

Is it possible to use __vmalloc_area()?

Oleg.
