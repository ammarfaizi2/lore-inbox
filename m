Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263381AbTDLTOu (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 15:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263382AbTDLTOu (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 15:14:50 -0400
Received: from brussels-smtp.planetinternet.be ([195.95.34.12]:17421 "EHLO
	firebird.planetinternet.be") by vger.kernel.org with ESMTP
	id S263381AbTDLTOr (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 15:14:47 -0400
From: Frank Van Damme <frank.vandamme@student.kuleuven.ac.be>
To: Mark Watts <m.watts@mrw.demon.co.uk>
Subject: Re: stabilty problems using opengl on kt400 based system
Date: Sat, 12 Apr 2003 21:26:27 +0200
User-Agent: KMail/1.5.1
References: <200304121410.58522.frank.vandamme@student.kuleuven.ac.be> <200304122010.52375.frank.vandamme@student.kuleuven.ac.be> <200304121920.38974.m.watts@mrw.demon.co.uk>
In-Reply-To: <200304121920.38974.m.watts@mrw.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304122126.27649.frank.vandamme@student.kuleuven.ac.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 April 2003 20:20, Mark Watts wrote:
> > I am not sure, but I though nVidia cards were different. I have used a
> > tnt2 before I had my radeon (I used it with that previous motherboard)
> > and back then, I have been advised to compile kernels without AGP support
> > since the nVidia drivers wouldn't use them anyway (despite the fact that
> > it was a 4x agp card). NVidia seems to have his own method of accessing
> > the agp bus.
>
> I'm not entirely sure how I tell what agp gart I'm using, but I have
> 'agpgart' loaded as a module...

I found it in the readme file of the nvidia drivers:

<QUOTE>
There are several choices for configuring the NVIDIA kernel module's
use of AGP: you can choose to either use NVIDIA's AGP module (NVAGP),
or the AGP module that comes with the linux kernel (AGPGART).  This is
controlled through the "NvAGP" option in your XF86Config file:

         Option "NvAgp" "0"  ... disables AGP support
         Option "NvAgp" "1"  ... use NVAGP, if possible
         Option "NvAgp" "2"  ... use AGPGART, if possible
         Option "NvAGP" "3"  ... try AGPGART; if that fails, try NVAGP

The default is 3 (the default was 1 until after 1.0-1251).
</QUOTE>

In other words, you use linux's agp drivers.

So it's probably not the agp driver that causes "hangs". 

-- 
Frank Van Damme    | "Saying 8MB of RAM doesn't do as much anymore is
http://www.        | like saying a gallon of water holds more than it
openstandaarden.be | did in 1988."                    --George Adkins

