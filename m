Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315259AbSFOK4S>; Sat, 15 Jun 2002 06:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSFOK4R>; Sat, 15 Jun 2002 06:56:17 -0400
Received: from skunk.directfb.org ([212.84.236.169]:1722 "EHLO
	skunk.directfb.org") by vger.kernel.org with ESMTP
	id <S315259AbSFOK4Q>; Sat, 15 Jun 2002 06:56:16 -0400
Date: Sat, 15 Jun 2002 12:55:47 +0200
From: Denis Oliver Kropp <dok@directfb.org>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Denis Oliver Kropp <dok@directfb.org>, Russell King <rmk@arm.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.5.21] CyberPro 32bit support and other fixes
Message-ID: <20020615105547.GA22186@skunk.convergence.de>
Reply-To: Denis Oliver Kropp <dok@directfb.org>
In-Reply-To: <20020613092323.GA2384@skunk.convergence.de> <Pine.LNX.4.44.0206141550000.21575-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting James Simmons (jsimmons@transvirtual.com):
> 
> > Why is the pseudo palette used anyway?
> 
> Its a fast way for the console to grab the proper console index color to
> draw to the framebuffer. Otherwise we have to regenerate the color all the
> time. Plus it is always endian code for us :-)

I didn't mean the array of colors for the console, but the usage of
the hardware palette for modes != 8 bit.

> > There's no speed benefit and
> > applications running in true/direct color would look wrong.
> 
> For userland no but for the kernel we do have a benifiet.

There's no speed benefit if you write "index|index|index" into the
framebuffer instead of "red|green|blue".

-- 
Best regards,
  Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"

                            Convergence GmbH
