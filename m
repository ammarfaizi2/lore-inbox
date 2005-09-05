Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbVIEPpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVIEPpU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 11:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVIEPpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 11:45:19 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:13075 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S932178AbVIEPpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 11:45:17 -0400
Date: Mon, 5 Sep 2005 17:45:09 +0200 (CEST)
From: gl@dsa-ac.de
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: who sets boot_params[].screen_info.orig_video_isVGA?
In-Reply-To: <E1ECIub-00088O-00@chiark.greenend.org.uk>
Message-ID: <Pine.LNX.4.63.0509051736420.11341@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0509051646480.11341@pcgl.dsa-ac.de>
 <E1ECIub-00088O-00@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply, Matthew.

On Mon, 5 Sep 2005, Matthew Garrett wrote:

> gl@dsa-ac.de <gl@dsa-ac.de> wrote:
>> I am trying to get intelfb running on a system with a 855GM onboard chip,
>> and the driver exits at intelfbdrv.c::intelfb_pci_register() (2.6.13, line
>> 814:
>>
>>  	if (FIXED_MODE(dinfo) && ORIG_VIDEO_ISVGA != VIDEO_TYPE_VLFB) {
>>  		ERR_MSG("Video mode must be programmed at boot time.\n");
>>  		cleanup(dinfo);
>>  		return -ENODEV;
>>  	}
>
> This ought to be done by the bootloader if you pass a vga=foo argument.
> The framebuffer driver doesn't know how to switch resolutions (primarily
> because Intel won't tell anyone how to do it, so the only method is a
> real-mode BIOS call to the VESA BIOS)

Do I get it right, that, say, if I tell grub to load a kernel and specify 
"vga=xxx" on the kernel command line, grub will interpret it, issue some 
VESA BIOS calls and fill in the screen_info struct? If so, the card often 
supports several modes (VGA, SVGA, VESA, different resolutions, colour 
depths, etc.), right? So, which one will be chosen? Does it depend on the 
specific value I give to "vga="? How do I force VIDEO_TYPE_VLFB (VESA VGA 
in graphic mode) mopde then?

BTW, I didn't find any code in grub that sets up screen_info, or it's very 
well hidden:-)

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
