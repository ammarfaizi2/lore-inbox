Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263345AbTKFH6P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 02:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263408AbTKFH6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 02:58:15 -0500
Received: from tarantel.rz.fh-muenchen.de ([129.187.244.239]:38114 "HELO
	mailserv.rz.fh-muenchen.de") by vger.kernel.org with SMTP
	id S263345AbTKFH6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 02:58:13 -0500
Date: Thu, 6 Nov 2003 09:01:32 +0100
From: Daniel Egger <degger@tarantel.rz.fh-muenchen.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Daniel Egger <degger@fhm.edu>, Dustin Lang <dalang@cs.ubc.ca>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Re:No backlight control on PowerBook G4
Message-ID: <20031106090132.B18367@tarantel.rz.fh-muenchen.de>
References: <Pine.GSO.4.53.0311021038450.3818@columbia.cs.ubc.ca> <1067820334.692.38.camel@gaston> <1067878624.7695.15.camel@sonja> <1067896476.692.36.camel@gaston> <1067976347.945.4.camel@sonja> <1068078504.692.175.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2us
In-Reply-To: <1068078504.692.175.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 06, 2003 at 11:28:25AM +1100, Benjamin Herrenschmidt wrote:

> > Just checked. It doesn't work with the  latest (Linus) 2.6-test and
> > radeonfb. Do you have any special patches in your tree for radeonfb?
 
> No, I told you to use _my_ 2.6 tree which contains a new radeonfb
> that have not yet been merged upstream.

I noticed that, however I do not have the bandwitdh to track several trees
simultaneously. Will do that on a high bandwidth machine and create a diff.

> bk://ppc.bkbits.net/linuxppc-2.5-benh or rsync from
> source.mvista.com::linuxppc-2.5-benh
 
> Yaboot normally loads a plain vmlinux, though if you are using tftp, you
> need to modify yaboot to be able to d/l more than 4Mb (edit fs_of.c and
> change the allocated size). 

This is probably it. The raw image is just a bit over 4 megs. Is there a
chance that this will change upstream? Also a warning would be nice while
creating the kernel as I'm probably not the only one experiencing this.

> The ELF image should work, at least the
> one produced by my tree does, it's possible that there's a similar size
> problem with the one in Linus tree, a few of those recent changes haven't
> yet made it to Linus.

Size problem? At least it's not triggered by the yaboot limitation because
the image is similar in size to zImage.chrp which would be around 1.8 megs.

--
Servus,
       Daniel
