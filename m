Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262899AbVDHRuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262899AbVDHRuR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 13:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbVDHRrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 13:47:05 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:42916 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262895AbVDHRqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 13:46:14 -0400
Date: Fri, 8 Apr 2005 19:45:47 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: rjy <rjy@angelltech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: init process freezed after run_init_process
In-Reply-To: <4255EF2A.709@angelltech.com>
Message-ID: <Pine.LNX.4.61.0504081944120.19971@yvahk01.tjqt.qr>
References: <424B7A87.2070100@angelltech.com> <Pine.LNX.4.61.0503311113550.17113@yvahk01.tjqt.qr>
 <4254AB72.8070704@angelltech.com> <Pine.LNX.4.61.0504071341500.27692@yvahk01.tjqt.qr>
 <4255EF2A.709@angelltech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Make your own initrd and put a bash into it. Then start that, e.g. (for
>> our linux live cd), initrd=initrd.sqfs root=/dev/ram0 init=/bin/bash
>
> I have tried these kernel parameters:
> init=/bin/bash
> init=/linuxrc
> init=/init
> init=/sbin/init
> None works.

What's the error message?

> Also, after some google, I found that the format of initrd has changed.
> I also tried a new initrd with cpio format. The kernel recognized it:

cpio initrd's (aka initramfs) are new - the "old style" initrd where you
`mksquasfs mydir initrd.sqfs` (see above) continues to work, though.

> After the kernel start, I add breakpoints at cpu_idle and do_schedule.
> cpu_idle never reached, only do_schedule did. Is that strange?

Until pid 1 is started, the cpu should never be idle.


Jan Engelhardt
-- 
No TOFU for me, please.
