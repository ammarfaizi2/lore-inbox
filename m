Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317056AbSFFSbJ>; Thu, 6 Jun 2002 14:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317073AbSFFSac>; Thu, 6 Jun 2002 14:30:32 -0400
Received: from [195.39.17.254] ([195.39.17.254]:47520 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317059AbSFFS3S>;
	Thu, 6 Jun 2002 14:29:18 -0400
Date: Sun, 2 Jun 2002 04:49:08 +0000
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        linux-kernel@vger.kernel.org,
        linux-hotplug-devel@lists.sourceforge.net,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: device model documentation 2/3
Message-ID: <20020602044907.A121@toy.ucw.cz>
In-Reply-To: <200206051253.g55Crs331876@fachschaft.cup.uni-muenchen.de> <Pine.LNX.4.33.0206051205150.654-100000@geena.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > SUSPEND_DISABLE tells the device to stop I/O transactions. When it
> > > stops transactions, or what it should do with unfinished transactions
> > > is a policy of the driver. After this call, the driver should not
> > > accept any other I/O requests.
> > 
> > Does this mean that memory allocations in the suspend/resume
> > implementations must be made with GFP_NOIO respectively
> > GFP_ATOMIC ?
> > It would seem so.
> 
> Why would you allocate memory on a resume transition? 
> 
> As for suspending, this is something that has been discussed a few times 
> before. No definitive decision has come out of it because it hasn't been 
> implemented yet. It hasn't been implemented yet because the infrastructure 
> isn't complete. It's real close, but still not quite there. 

swsusp works for me (tm). SO structure should be there ;-)

> Nonetheless, you have to do one of a couple things: use GFP_NOIO or
> special case the swap device(s) so they don't stop I/O when everything
> else does. (Of course, you have to eventually stop it)

Special casing swap is not enough -- you can well have memory full of data
for regular filesystem.

								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

