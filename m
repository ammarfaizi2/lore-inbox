Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbTDMIF7 (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 04:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbTDMIF7 (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 04:05:59 -0400
Received: from mrw.demon.co.uk ([194.222.96.226]:1920 "EHLO rebecca")
	by vger.kernel.org with ESMTP id S263388AbTDMIF5 convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 04:05:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mark Watts <m.watts@mrw.demon.co.uk>
To: Frank Van Damme <frank.vandamme@student.kuleuven.ac.be>
Subject: Re: stabilty problems using opengl on kt400 based system
Date: Sun, 13 Apr 2003 09:17:43 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200304121410.58522.frank.vandamme@student.kuleuven.ac.be> <200304121920.38974.m.watts@mrw.demon.co.uk> <200304122126.27649.frank.vandamme@student.kuleuven.ac.be>
In-Reply-To: <200304122126.27649.frank.vandamme@student.kuleuven.ac.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304130917.43379.m.watts@mrw.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 Apr 2003 8:26 pm, Frank Van Damme wrote:
> On Saturday 12 April 2003 20:20, Mark Watts wrote:
> > > I am not sure, but I though nVidia cards were different. I have used a
> > > tnt2 before I had my radeon (I used it with that previous motherboard)
> > > and back then, I have been advised to compile kernels without AGP
> > > support since the nVidia drivers wouldn't use them anyway (despite the
> > > fact that it was a 4x agp card). NVidia seems to have his own method of
> > > accessing the agp bus.
> >
> > I'm not entirely sure how I tell what agp gart I'm using, but I have
> > 'agpgart' loaded as a module...
>
> I found it in the readme file of the nvidia drivers:
>
> <QUOTE>
> There are several choices for configuring the NVIDIA kernel module's
> use of AGP: you can choose to either use NVIDIA's AGP module (NVAGP),
> or the AGP module that comes with the linux kernel (AGPGART).  This is
> controlled through the "NvAGP" option in your XF86Config file:
>
>          Option "NvAgp" "0"  ... disables AGP support
>          Option "NvAgp" "1"  ... use NVAGP, if possible
>          Option "NvAgp" "2"  ... use AGPGART, if possible
>          Option "NvAGP" "3"  ... try AGPGART; if that fails, try NVAGP
>
> The default is 3 (the default was 1 until after 1.0-1251).
> </QUOTE>
>
> In other words, you use linux's agp drivers.
>
> So it's probably not the agp driver that causes "hangs".

You're right - I don't have any NvAgp options in my X config.

Not sure these will help but here are some of the versions of thinks I run:

[mwatts@rebecca mwatts]$ xdpyinfo
name of display:    :0.0
version number:    11.0
vendor string:    Mandrake Linux (XFree86 4.2.1, patch level 3mdk)
vendor release number:    40201000
XFree86 version: 4.2.1

glibc-2.2.5-16mdk

NVIDIA-Linux-x86-1.0-4349.run (uses custom compiled kernel interface for 
2.4.21)

[root@rebecca linux-2.4.21-0.12mdk]# grep AGP .config
CONFIG_AGP=m
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
# CONFIG_AGP_AMD_8151 is not set
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
CONFIG_AGP_SWORKS=y


