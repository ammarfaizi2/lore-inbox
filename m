Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWGKTis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWGKTis (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWGKTir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:38:47 -0400
Received: from terminus.zytor.com ([192.83.249.54]:7610 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751208AbWGKTiq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:38:46 -0400
Message-ID: <44B3FE34.9000704@zytor.com>
Date: Tue, 11 Jul 2006 12:38:28 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Olaf Hering <olh@suse.de>, Jeff Garzik <jeff@garzik.org>,
       Michael Tokarev <mjt@tls.msk.ru>, Roman Zippel <zippel@linux-m68k.org>,
       klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
References: <20060711164040.GA16327@suse.de> <44B3DA77.50103@garzik.org> <20060711171624.GA16554@suse.de> <44B3DEA0.3010106@zytor.com> <20060711173030.GA16693@suse.de> <44B3E40E.2090306@zytor.com> <20060711180126.GB16869@suse.de> <44B3E814.3060004@zytor.com> <20060711181055.GC16869@suse.de> <44B3EB28.1050007@zytor.com> <20060711191548.GA17585@suse.de> <Pine.LNX.4.64.0607111226320.5623@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607111226320.5623@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 11 Jul 2006, Olaf Hering wrote:
>>> It's a proposal, and I personally think it makes sense.  If done, it is 
>>> obviously very important that it doesn't change the overall operation of 
>>> the system.
>> I think you can have that today, parted uses BLKPG to add and remoe
>> things. No idea what the benefit would be, but thats not relavant for
>> kinit or no kinit.
> 
> The notion that the kernel itself should do no partition parsing at all 
> was advocated by Andries Brouwer. I violently disagree. Anything that the 
> lack of which makes a normal system basically unusable should go into the 
> kernel.
> 

Does that mean "in kernel space", "in the kernel distribution" or "in 
memory completely under the control by the kernel?"  That is really what 
this is about.

There could be a klibc-build binary in rootfs, build at the time the 
kernel was built, that can be invoked by the kernel in parallel with 
/sbin/hotplug.

> Yes, the kernel rules are heuristics, but so would inevitably any 
> user-level rules be too, so I don't want to move partition detection to 
> initrd or similar.

The whole point of putting klibc in the kernel tree is so we can do this 
kind of stuff without breaking the stock kernel build as a 
self-contained entity.  Without that objective, Olaf is right that it is 
not necessary.

	-hpa
