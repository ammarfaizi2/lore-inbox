Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284197AbRLAShS>; Sat, 1 Dec 2001 13:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284194AbRLAShI>; Sat, 1 Dec 2001 13:37:08 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:41405 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S284195AbRLAShA>; Sat, 1 Dec 2001 13:37:00 -0500
Date: Sat, 1 Dec 2001 11:36:59 -0700
Message-Id: <200112011836.fB1IaxY31897@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre5 not easy to boot with devfs
In-Reply-To: <3C0898AD.FED8EF4A@wanadoo.fr>
In-Reply-To: <3C085FF3.813BAA57@wanadoo.fr>
	<9u9qas$1eo$1@penguin.transmeta.com>
	<200112010701.fB171N824084@vindaloo.ras.ucalgary.ca>
	<3C0898AD.FED8EF4A@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Rousselet writes:
> Richard Gooch wrote:
> > Indeed I do. Please Cc: me on devfs related stuff. And please apply
> > devfs-patch-v200, which fixes a stupid typo. I'd also be interested in
> > knowing the behaviour with 2.4.17-pre1.

Did you apply devfs-patch-v200?

> > and boot messages. And booting with
> 
> Difficult, I have no log in this case. I don't see unusual message
> before the oops except :

I need those boot messages.

> none already mounted on /dev

Edit your /etc/fstab and remove the line for devfs. You don't
need/want that if you have CONFIG_DEVFS_MOUNT=y.

> /dev is only a mountpoint on my system. I have no other fallback without
> devfs but a working kernel (thanksfully there are plenty).
> 
> > "devfs=dall" is required as well.
> 
> No option appended (no 'devfs='). grub.

I know nothing about grub. Somehow, you need to pass "devfs=dall" to
the kernel when booting. And I need to see the boot messages when this
option is given to the kernel. If it's too verbose, you can try
"devfs=dreg,dunreg,dfree" instead. Copy the messages down by hand if
you need to, but I need to see them. Do yourself a favour and set up a
serial console so you can capture boot messages easily.

Also, make sure you are not using any proprietary drivers (like
NVidia). If you have such drivers, move them to another directory to
prevent their being loaded. Even if you load but don't use such
drivers, they still make debugging information unreliable.

I've had a look at the code, and I see no reason for devfs to fail in
this way, unless some driver is abusing it.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
