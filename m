Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269543AbRHHVVd>; Wed, 8 Aug 2001 17:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269545AbRHHVVN>; Wed, 8 Aug 2001 17:21:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23303 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S269543AbRHHVVC>;
	Wed, 8 Aug 2001 17:21:02 -0400
Date: Wed, 8 Aug 2001 22:21:06 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: salvador <salvador@inti.gov.ar>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: [RFC] Get selection to buffer addition
Message-ID: <20010808222106.C22093@flint.arm.linux.org.uk>
In-Reply-To: <3B66A90D.789A90A8@inti.gov.ar> <3B66DDEB.1EA1FEC@inti.gov.ar> <20000101012446.B27@(none)>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20000101012446.B27@(none)>; from pavel@suse.cz on Sat, Jan 01, 2000 at 01:24:46AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 01, 2000 at 01:24:46AM +0000, Pavel Machek wrote:
> Hi!
> 
> > I'm sending this mail again with the patch in plain text and not
> > gzip+uuencoded, sorry for any inconvenience.
> > 
> > What I'm looking for:
> >   I'm looking for comments and approval for a small addition to the console
> > driver (drivers/char/console.c).
> > 
> > Small description:
> >   The included patches adds a couple of new services to the TIOCLINUX ioctl
> > call, they are:
> > 
> > 13 (get selection into a buffer): It copies the contents of the selection
> > buffer (maintained in kernel space) into a user space provided buffer. Is
> > something like "paste to a buffer"  instead of just paste to the current
> > console.
> > 
> > 14 (get selection length): Returns the length of the selection buffer (0 if
> > none selected).
> 
> Looks good to me. Now, all I want is utility to share clipboard between
> X and text console...

Umm, silly question, but why not put this stuff into something similar to
gpm, rather than have unswappable kernel memory sucked up just for cut and
paste (possibly very large cut and paste under X).

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

