Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSFOODe>; Sat, 15 Jun 2002 10:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315410AbSFOODd>; Sat, 15 Jun 2002 10:03:33 -0400
Received: from skunk.directfb.org ([212.84.236.169]:45499 "EHLO
	skunk.directfb.org") by vger.kernel.org with ESMTP
	id <S315406AbSFOODc>; Sat, 15 Jun 2002 10:03:32 -0400
Date: Sat, 15 Jun 2002 16:03:03 +0200
From: Denis Oliver Kropp <dok@directfb.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Denis Oliver Kropp <dok@directfb.org>,
        James Simmons <jsimmons@transvirtual.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.5.21] CyberPro 32bit support and other fixes
Message-ID: <20020615140303.GA22264@skunk.convergence.de>
Reply-To: Denis Oliver Kropp <dok@directfb.org>
In-Reply-To: <20020613092323.GA2384@skunk.convergence.de> <Pine.LNX.4.44.0206141550000.21575-100000@www.transvirtual.com> <20020615105547.GA22186@skunk.convergence.de> <20020615133050.A15283@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Russell King (rmk@arm.linux.org.uk):
> On Sat, Jun 15, 2002 at 12:55:47PM +0200, Denis Oliver Kropp wrote:
> > > > There's no speed benefit and
> > > > applications running in true/direct color would look wrong.
> > > 
> > > For userland no but for the kernel we do have a benifiet.
> > 
> > There's no speed benefit if you write "index|index|index" into the
> > framebuffer instead of "red|green|blue".
> 
> You're actually asking the wrong question.  "Why is there such a thing as
> directcolor" would be a better question.  After all, if there's no "speed
> benefit" when why do manufacturers bother implementing it?
> 
> Could it be because it allows colours to be dynamically allocated?  Given
> a "good enough" allocator which looks over your complete colour usage, you
> could probably make better use of the available colours than truecolor
> allows.

I don't think that the text console with 16 different colors needs more
precision than 5 bits per color channel (speaking of RGB555).

However, using directcolor to have a gamma ramp in user space applications
seems quite useful.

Drivers should support both direct- and truecolor for all bit depths with
default to truecolor, otherwise applications would always have to setup
the palette.

Anyway, the current version of the cyber2000 driver reports directcolor
while programming the hardware for truecolor. I can do another patch
that keeps the directcolor feature along with the other fixes.

-- 
Best regards,
  Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"

                            Convergence GmbH
