Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313550AbSDHE2D>; Mon, 8 Apr 2002 00:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313551AbSDHE2C>; Mon, 8 Apr 2002 00:28:02 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:6664 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S313550AbSDHE2B>; Mon, 8 Apr 2002 00:28:01 -0400
Message-Id: <200204080427.g384Re999479@aslan.scsiguy.com>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.19-pre6 standardize {aic7xxx,aicasm}/Makefile 
In-Reply-To: Your message of "Mon, 08 Apr 2002 13:54:02 +1000."
             <32231.1018238042@kao2.melbourne.sgi.com> 
Date: Sun, 07 Apr 2002 22:27:40 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>That is a deliberate design decision, the installed module under
>/lib/modules has the same name and relative path as the object that is
>built in the kernel tree.  Keeping them the same makes it much easier
>to debug kernel problems, a module called aic7xxx_experimental.o could
>come from anywhere.

That's a pretty weak argument coming from an OS that doesn't ship
with a kernel debugger <grumble> by default.   After all, modules
can still come from anywhere (say a floppy).  I still think
this is a silly policy, but as you can see by the recent renaming
of the driver files, I've come to accept it. 8-)

>Having multiple conglomerates gets messy, especially if you allow a
>mixture of built in and modular selection and if it is possible for
>everything to be a module with no built in stubs.  The generic case
>looks like this

Since this is the case, and the Makefile will return to this format
as soon as the U320 driver is released, can we come up with an
interrim Makefile that assumes the new driver will show up shortly?

>Because the above processing for multiple conglomerates is so messy, a
>lot of developers use multiple directories, each containing one
>conglomerate.  Then you can fall back on the default Rules.make
>processing in each directory.

Both drivers use the same assembler.  Otherwise I would have split
the second out into its own directory.

--
Justin
