Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129663AbQLAU2r>; Fri, 1 Dec 2000 15:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130290AbQLAU22>; Fri, 1 Dec 2000 15:28:28 -0500
Received: from stm.lbl.gov ([131.243.16.51]:12553 "EHLO stm.lbl.gov")
	by vger.kernel.org with ESMTP id <S129821AbQLAU1c>;
	Fri, 1 Dec 2000 15:27:32 -0500
Date: Fri, 1 Dec 2000 11:43:47 -0800
To: David Woodhouse <dwmw2@infradead.org>
Cc: Timur Tabi <ttabi@interactivesi.com>, linux-kernel@vger.kernel.org
Subject: Re: Pls add this driver to the kernel tree !!
Message-ID: <20001201114347.A3439@stm.lbl.gov>
Reply-To: David Schleef <ds@schleef.org>
In-Reply-To: <20001130203703Z129437-440+118@vger.kernel.org> <200011301803.eAUI3Pu16137@webber.adilger.net> <20001130203703Z129437-440+118@vger.kernel.org> <24827.975662789@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <24827.975662789@redhat.com>; from dwmw2@infradead.org on Fri, Dec 01, 2000 at 09:26:29AM +0000
From: David Schleef <ds@stm.lbl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2000 at 09:26:29AM +0000, David Woodhouse wrote:
> 
> ttabi@interactivesi.com said:
> >  Not necessarily - it all depends on what your driver does.  In many
> > cases, supporting 2.2 and 2.4 is easy, and all you need are a few
> > #if's.  It's certainly much better to have a dozen or so #if's
> > sprinkled throughout the code than to have two separate source trees,
> > and have to make the same change to multiple files.
> 
> It's even better to do it without the ugly preprocessor magic - see 
> include/linux/compatmac.h
> 
> There are a few things missing from there - include/linux/mtd/compatmac.h 
> has more. One day we'll get round to removing the latter and merging it 
> into the main one, hopefully. 


A while ago, I started working on the Mother Of All compatmac.h files,
trying to merge Don Becker's stuff, yours, David Hinds, and stuff
from my own Comedi package.  It quickly got out of control, as
including compatmac.h (or kern_compat.h, as I called it) would
include most of the include/linux directory.  I've since settled for
setting up a separate include/linux tree with header files
named pci.h, mm.h, etc., that #define the right things and then
do an #include_next.  Interested parties can find it in Comedi
(http://stm.lbl.gov/comedi).




dave...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
