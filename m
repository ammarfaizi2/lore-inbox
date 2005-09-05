Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbVIEP3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbVIEP3e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 11:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbVIEP3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 11:29:34 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:5301 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S932307AbVIEP3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 11:29:34 -0400
To: gl@dsa-ac.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: who sets boot_params[].screen_info.orig_video_isVGA?
In-Reply-To: <Pine.LNX.4.63.0509051646480.11341@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0509051646480.11341@pcgl.dsa-ac.de>
Date: Mon, 5 Sep 2005 16:29:33 +0100
Message-Id: <E1ECIub-00088O-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gl@dsa-ac.de <gl@dsa-ac.de> wrote:
> Hi all,
> 
> I am trying to get intelfb running on a system with a 855GM onboard chip, 
> and the driver exits at intelfbdrv.c::intelfb_pci_register() (2.6.13, line 
> 814:
> 
>  	if (FIXED_MODE(dinfo) && ORIG_VIDEO_ISVGA != VIDEO_TYPE_VLFB) {
>  		ERR_MSG("Video mode must be programmed at boot time.\n");
>  		cleanup(dinfo);
>  		return -ENODEV;
>  	}

This ought to be done by the bootloader if you pass a vga=foo argument.
The framebuffer driver doesn't know how to switch resolutions (primarily
because Intel won't tell anyone how to do it, so the only method is a
real-mode BIOS call to the VESA BIOS)

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
