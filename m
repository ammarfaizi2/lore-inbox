Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbVIFHcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbVIFHcW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 03:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbVIFHcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 03:32:22 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:6151 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S932432AbVIFHcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 03:32:22 -0400
Date: Tue, 6 Sep 2005 09:32:07 +0200 (CEST)
From: gl@dsa-ac.de
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: who sets boot_params[].screen_info.orig_video_isVGA?
In-Reply-To: <431CEEAF.5090701@gmail.com>
Message-ID: <Pine.LNX.4.63.0509060918310.11341@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0509051646480.11341@pcgl.dsa-ac.de>
 <E1ECIub-00088O-00@chiark.greenend.org.uk> <Pine.LNX.4.63.0509051736420.11341@pcgl.dsa-ac.de>
 <431CEEAF.5090701@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Sep 2005, Matthew Garrett wrote:

> Yup. You probably want to take a look at Documentation/fb/vesafb.txt -
> the modes are the same.

Great, thanks! I tried VESA 0x111 (Linux 0x311) - it is also what is used 
by xfree86 vesa driver, after I've followed the suggestion from Tony 
(cc'ed and quoted below) and tried X with vesa. The kernel boots, intelfb 
driver doesn't exit, I can even start X over fb and it runs! But:

1) both screens - LCD and CRT bocome black as soon as intelfb takes over 
and stay that way also under X

2) kernel logs fill with

intelfb: the cursor was killed - restore it !!
intelfb: size 8, 16   pos 0, 464

Buggy video BIOS?...

On Tue, 6 Sep 2005, Antonino A. Daplas wrote:

> One good method is to use the "vesa" driver of Xorg/Xfree86.  Check
> /var/log/X*.log and it should have a nice list of vesa mode id's that
> are supported.
>
> Then add 0x200 to any of them and use it in your vga= parameter.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
