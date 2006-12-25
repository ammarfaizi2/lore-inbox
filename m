Return-Path: <linux-kernel-owner+w=401wt.eu-S1751665AbWLYTqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbWLYTqB (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 14:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbWLYTqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 14:46:01 -0500
Received: from squawk.glines.org ([72.36.206.66]:51507 "EHLO squawk.glines.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751655AbWLYTqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 14:46:00 -0500
Message-ID: <45902A6F.4000100@glines.org>
Date: Mon, 25 Dec 2006 11:45:51 -0800
From: Mark Glines <mark@glines.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061221)
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.20-rc2: forgot how to make a zImage on powerpc?
References: <fa.ne7N9dqjDz5qS4D/fowPKdPc4ZY@ifi.uio.no> <fa.pM17YEcICUlveSt/vbSKGv6sFWk@ifi.uio.no>
In-Reply-To: <fa.pM17YEcICUlveSt/vbSKGv6sFWk@ifi.uio.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Glines wrote:
> Hmm.  I'm trying to build 2.6.20-rc2 on a little powerpc box with 
> arch/powerpc/configs/linkstation_defconfig, and I get:
...
>   MODPOST vmlinux
> ln: accessing `arch/powerpc/boot/zImage': No such file or directory
> make[1]: *** [arch/powerpc/boot/zImage] Error 1
> make: *** [zImage] Error 2
> 
> So, uh, are we forgetting to go into the right subdirectory to make the 
> actual zImage, or what?  If I'm just doing something wrong, I'd love to 
> know what it is.
> 
> I'll follow up here on lkml if I diagnose this further.  Thanks,


Followup:  Yeah, it looks like it just doesn't know which format of 
zImage to produce for linkstation.

I'm not sure what image should be used by default.  I guess it depends 
on the bootloader.  Maybe default to uImage, as uBoot seems to be fairly 
common on these devices?

Mark
