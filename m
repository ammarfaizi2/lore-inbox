Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263263AbSJHVq4>; Tue, 8 Oct 2002 17:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263267AbSJHVqz>; Tue, 8 Oct 2002 17:46:55 -0400
Received: from pc132.utati.net ([216.143.22.132]:6562 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S263263AbSJHVqw>; Tue, 8 Oct 2002 17:46:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Matt Porter <porter@cox.net>
Subject: Re: The end of embedded Linux?
Date: Tue, 8 Oct 2002 12:52:21 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10210051252130.21833-100000@master.linux-ide.org> <20021008005030.C0DDF630@merlin.webofficenow.com> <20021008080445.B21266@home.com>
In-Reply-To: <20021008080445.B21266@home.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021008215220.68BF3544@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 October 2002 11:04 am, Matt Porter wrote:
> On Mon, Oct 07, 2002 at 03:50:43PM -0400, Rob Landley wrote:
>
> > Another very real option here is Documentation/tinykernel.txt.  (Possibly
> > even going so far as a brief mention of uclibc and busybox/tinylogin, but
> > mostly just about choping down the kernel for embedding in nosehair
> > trimmers and electric toothbrushes and such.)
>
> I don't see these as mutually exclusive.

Neither do I, but an "incredible shrinking kernel HOWTO" is less intrusive 
than marking up the source code with #ifdefs..

> Documentation falls out of
> date because it is often not maintained with the code.  This would
> certainly be the case of a file detailing means to tweak a wide
> array of settings in the kernel.
>
> Having the settings controlled somewhere in the kernel forces the
> settings to not be broken as we move forward.

Really?  Since when?

Go into make menuconfig in 2.4.19.  Switch off "scsi support".  Back to the 
main menu, try to descend into "fusion mpt device support".  The menu still 
shows up (at the top level, I might add), but you can't go into it.

That's been broken for over a year now.  It's in the top level of menuconfig. 
 I first reported it back around 2.4.6 or so.  It just doesn't get in 
anybody's way, and that area of code is a mess, and not fixing it isn't 
embarassing anybody specific.

Putting stuff into the mainstream kernel doesn't force it to be maintained by 
pixies.  It's just that stuff that stays broken long enough, which nobody 
steps up to fix, gets removed.

The main difference between code in the tree and Documentation/ in the tree 
is that if something is broken, you have to fix your copyof the code to get 
it to work for you, so it's not much more work to send in a patch.  At that 
point, the work of updating your tree is already done, and if you don't send 
in the patch you've got to fix it again next release..

If the documentation is broken, and you sit down and figure out how to do it, 
you haven't already written up a howto.  You won't get anything out of the 
howto at that point, but there's significant extra work in getting the docs 
updated that comes AFTER the bit you can't help but do.

So there are advantages to having code in the tree, but it's not a magic 
bullet...

> I believe some finer grained controls (less than 8000 hopefully)
> coupled with some basic docs pointing out where they can be configured,
> a description of some of the more interesting ones, and mentioning some
> non-kernel tools would be quite appropriate.

A hybrid approach does sound best...

> Regards,

Rob
