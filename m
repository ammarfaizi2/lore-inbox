Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbVC1Qwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVC1Qwq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 11:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVC1Qwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 11:52:46 -0500
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:64008 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S261944AbVC1Qwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 11:52:40 -0500
Date: Mon, 28 Mar 2005 17:52:37 +0100 (BST)
From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
In-Reply-To: <20050326182828.GA8540@kroah.com>
Message-ID: <Pine.LNX.4.10.10503281632100.18224-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

If you read the Linux Kernel header file "linux/module.h", there is a
section about Licenses. If "Proprietary" licences are not leagal, then why
are they supported ?

The implication of providing support for them in the header file is that
it is leagal to create and supply them.

I am porting a driver to Linux for a third party. I do not know if they
whish to release the Linux driver under GPL so I have assumed (because of
the nature of the hardware) that they do not whish to. I will discus this
matter with them when I have finnished the driver.

The use of header files to build a propriatory object files/binaries or
the use of GCC to compile such a file does not breach GPL as if it did,
GCC and GLIBC would not be available for non GPL platforms and it would
not be posible to provide propriatory code for use in a Linux/GNU
environment.

The Linux Kernel internal APIs are not mensioned in the Kernel GPL so it
can be argued quite reasonably that the APIs are not coverd by the GPL.

With regard to derived work - mensioned in a number of responses, a new
driver ported from MS Windows is derived from the Windows Driver not the
Linux Kernel. If it can be shown that there are sections of code in the
new driver that have been coppied from other Linux drivers, then there is
a good argument with regard to derived code but it would still be very
difficult to prove that this code had not been written totally
independantly from the Linux drivers containing the same or similar code.
In addition the driver is being built as a module, out side of the kernel
source tree and as a result can be considered to be separate enterty to
the kernel. If it was required to be built into the kernel as apposed to
being a Kernel Module then it would be totally different and the driver
would need to be GPL.

The hardware that this driver is being written for is low volume, very
specialised (with regard to its application). The driver will only be of
interest to thoes who have or can aford to purchase this hardware and are
in an appropriate buisiness sector. Given this, I see little point in
making the driver GPL as the code will be of little interest to anyone who
will not already have access to it through the supplier of the hardware it
is written for. For thoes writing Linux drivers, there are a number of
Books that can be read on this subject.

The Linux Kernel used with the driver will be probably purchesed
independently as part of a standard Linux distribution. As I am not
changing any of that code, I am not in breach of the GPL associated with
that code. A device driver may or may not be derived from other drivers in
the Linux Kernel. In this case it is not so it is not covered by the
Kernel GPL. If the customer requires a linux kernel then I will be quite
happy to provide one configured to meet their requirements with all the
source code (as available from the various ftp mirrors) and any private
patches I may have applied, as per the terms and conditions in the
"COPYING" file in the kernel source tree.

I wait with interest for your comments.

Regards
	Mark Fortescue.

On Sat, 26 Mar 2005, Greg KH wrote:

> On Sat, Mar 26, 2005 at 05:52:20PM +0000, Mark Fortescue wrote:
> > 
> > I am writing a "Proprietry" driver module for a "Proprietry" PCI card and
> > I have found that I can't use SYSFS on Linux-2.6.10.
> > 
> > Why ?. 
> 
> What ever gave you the impression that it was legal to create a
> "Proprietry" kernel driver for Linux in the first place.  I seriously
> encourage you to consult your company's legal department if you insist
> on attempting to do this, as they will be contacted by others after your
> driver is released.
> 
> > I am not modifing the Kernel/SYSFS code so I should be able, to use all
> > the SYSFS/internal kernel function calls without hinderence.
> 
> I'm sorry, but as you have found out, that is not possible.
> 
> > I believe that this sort of idiocy is what helps Microsoft hold on to its
> > manopoly and as shuch hinders hardware/software development in all areas
> > and should be chanaged in a way that promotes diversified software
> > development.
> 
> If your company does not agree with the current license of the Linux
> kernel, which prevents you from creating "Proprietry" drivers, then do
> not write or create such drivers in the first place.  We (the kernel
> community) are not forcing you to write a Linux driver.
> 
> However, if you do wish to create a Linux driver, you _must_ abide by
> the legal requirements of the kernel, which I feel, along with every IP
> lawyer I have ever consulted, that it is not allowed to create a non-GPL
> compatible kernel module.
> 
> Good luck,
> 
> greg k-h
> 

