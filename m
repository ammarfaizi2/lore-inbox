Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135900AbREDHru>; Fri, 4 May 2001 03:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135901AbREDHra>; Fri, 4 May 2001 03:47:30 -0400
Received: from zmailer.org ([194.252.70.162]:61961 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S135900AbREDHrZ>;
	Fri, 4 May 2001 03:47:25 -0400
Date: Fri, 4 May 2001 10:47:10 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Yiping Chen <YipingChen@via.com.tw>
Cc: "'linux_news'" <linux-kernel@vger.kernel.org>
Subject: Re: Whether can we put our company's  linux driver into linux kernel?
Message-ID: <20010504104710.D28803@mea-ext.zmailer.org>
In-Reply-To: <611C3E2A972ED41196EF0050DA92E0760265D595@EXCHANGE2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <611C3E2A972ED41196EF0050DA92E0760265D595@EXCHANGE2>; from YipingChen@via.com.tw on Thu, May 03, 2001 at 10:46:13PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2001 at 10:46:13PM +0800, Yiping Chen wrote:
> I want to contact with  the author of linux kernel. 
> Anybody knows how to contact with them?

   "linux-kernel@vger.kernel.org" list is quite good way for that.

> Our leader hope put our own driver into linux kernel.
> I am not sure whether it was permitted.

   It is even encouraged.  As has been mentioned here before, each
   Linux kernel source tarball (at least 2.4.* series) has file:

       Documentation/SubmittingDrivers

   which describes the method.


   Of course we (the fuzzy thing called "user community") would prefer
   to have nice sourcecode with lots of comments telling why something
   is done in a way it is done, especially when it is a matter of poking
   some lowlevel things in the hardware.

   We see also highly obscured driver(s) appearing from various vendors,
   which support some single spot revision(s) of kernel(s).  This includes
   binary-only drivers...

   While vendors may have reasons not to publish some details of how to
   drive their hardware, usually it only makes their hardware less attractive
   for Linux users when the drivers are limited to i386 architecture and
   only some very few kernels by given vendors.

   While Linux kernels with even second number (2.4.* as an example)
   will TRY TO maintain internal API consistent, even down to BINARY
   format, that might not always be so.

   Especially there exists a radical difference in between multiprocesor
   kernels (SMP), and uniprocessor kernels.  So radical that they are
   binary incompatible.  (This is configuration option before compiling
   the kernel.)    YOU (driver author) should always write SMP safe code
   with spinlocks protecting access to codepaths/data-areas needing
   consistent serialized access.  Compilation will optimize away the
   spinlocks in uniprocessor setups.


   A well written driver is supplied in source, and is easily readable
   by other people who need to go over the entire kernel for some subtle
   detail changes over the next development phases (such has happened
   before, and will likely happen again.)

   A well written driver will very likely work at hardware with different
   endianity than i386 architecture of PCs -- for example PowerPC machines.
   (Of course core-logic drivers don't need to work anything but i386 PC,
    but PCI interfaced peripheral gizmo can be used anywhere.)


> So, I need to contact with the authors of linux kernel.
> If you know how to do it, please tell me.
> Thanks!!
> Yiping Chen

/Matti Aarnio <matti.aarnio@zmailer.org>
