Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWGKU6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWGKU6X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 16:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWGKU6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 16:58:23 -0400
Received: from terminus.zytor.com ([192.83.249.54]:31967 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751320AbWGKU6W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 16:58:22 -0400
Message-ID: <44B410D2.5090609@zytor.com>
Date: Tue, 11 Jul 2006 13:57:54 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Olaf Hering <olh@suse.de>, Jeff Garzik <jeff@garzik.org>,
       Michael Tokarev <mjt@tls.msk.ru>, Roman Zippel <zippel@linux-m68k.org>,
       klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
References: <20060711164040.GA16327@suse.de> <44B3DA77.50103@garzik.org> <20060711171624.GA16554@suse.de> <44B3DEA0.3010106@zytor.com> <20060711173030.GA16693@suse.de> <44B3E40E.2090306@zytor.com> <20060711180126.GB16869@suse.de> <44B3E814.3060004@zytor.com> <20060711181055.GC16869@suse.de> <44B3EB28.1050007@zytor.com> <20060711191548.GA17585@suse.de> <Pine.LNX.4.64.0607111226320.5623@g5.osdl.org> <44B3FE34.9000704@zytor.com> <Pine.LNX.4.64.0607111249380.5623@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607111249380.5623@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 11 Jul 2006, H. Peter Anvin wrote:
>> Does that mean "in kernel space", "in the kernel distribution" or "in memory
>> completely under the control by the kernel?"  That is really what this is
>> about.
> 
> I think it's all about kernel space.
> 
> Moving the default parsing to user space would add exactly _zero_ 
> advantage, and would add totally unnecessary complexity (ie now we need to 
> make sure that hotplug does it right - and the hotplug routines suddenly 
> change between the boot phase and the actual install).
> 

There is no reason the hotplug routines should change between the boot 
phase and actual install.  Please note that I didn't say "instead of 
/sbin/hotplug", I said in rootfs in addition to /sbin/hotplug.

If it adds complexity, it's The Wrong Thing.  However, it seems very 
strange to me to draw the boundary at the kernel-space boundary.

	-hpa

