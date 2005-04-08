Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262595AbVDHChT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262595AbVDHChT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 22:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbVDHChT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 22:37:19 -0400
Received: from [61.185.204.103] ([61.185.204.103]:42403 "EHLO
	dns.angelltech.com") by vger.kernel.org with ESMTP id S262595AbVDHChN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 22:37:13 -0400
Message-ID: <4255EF2A.709@angelltech.com>
Date: Fri, 08 Apr 2005 10:40:42 +0800
From: rjy <rjy@angelltech.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: init process freezed after run_init_process
References: <424B7A87.2070100@angelltech.com> <Pine.LNX.4.61.0503311113550.17113@yvahk01.tjqt.qr> <4254AB72.8070704@angelltech.com> <Pine.LNX.4.61.0504071341500.27692@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0504071341500.27692@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Apply these rules:
> 1.) If you do provide an initrd= thing, the initrd is being looked for 
> /linuxrc.

I have add /linuxrc, /init and /bin/init, all link to /sbin/init.
It just refuses to work ... :(

> Only VIA IDE chipset maybe, but you don't usually need that for just-initrd.
> You'd need that for the harddisks...

My harddisk works fine without initrd.

> 
> Make your own initrd and put a bash into it. Then start that, e.g. (for our 
> linux live cd), initrd=initrd.sqfs root=/dev/ram0 init=/bin/bash

I have tried these kernel parameters:
	init=/bin/bash
	init=/linuxrc
	init=/init
	init=/sbin/init
None works.

Also, after some google, I found that the format of initrd has changed.
I also tried a new initrd with cpio format. The kernel recognized it:
	Boot Logs:
	1) checking if image is initramfs... it is
	   Freeing initrd memory: 17583k freed
	2) loading drivers
	3) Freeing unused kernel memory: 128k freed

After the kernel start, I add breakpoints at cpu_idle and do_schedule.
cpu_idle never reached, only do_schedule did. Is that strange?
