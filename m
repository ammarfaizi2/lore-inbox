Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132833AbRDELqo>; Thu, 5 Apr 2001 07:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131830AbRDELqd>; Thu, 5 Apr 2001 07:46:33 -0400
Received: from mail.zmailer.org ([194.252.70.162]:30724 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S132767AbRDELqW>;
	Thu, 5 Apr 2001 07:46:22 -0400
Date: Thu, 5 Apr 2001 14:45:34 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Manoj Sontakke <manojs@sasken.com>
Cc: Alexander Viro <viro@math.psu.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: which gcc version?
Message-ID: <20010405144534.A873@mea-ext.zmailer.org>
In-Reply-To: <Pine.GSO.4.21.0104050147290.23164-100000@weyl.math.psu.edu> <Pine.LNX.4.21.0104051930580.2687-100000@pcc65.sasi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0104051930580.2687-100000@pcc65.sasi.com>; from manojs@sasken.com on Thu, Apr 05, 2001 at 07:39:14PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2001 at 07:39:14PM +0530, Manoj Sontakke wrote:
> hi
> 
> On Thu, 5 Apr 2001, Alexander Viro wrote:
> > On Thu, 5 Apr 2001, Manoj Sontakke wrote:
> > 
> > > Hi
> > > 	I am getting linker error "undefined reference to __divdi3".
> > > This is because c = a/b; where a,b,c are of type "long long"
> > > I understand this is gcc problem.
> > > 	I am doing this on a pentium with gcc -v = egcs-2.91.66
> > 
> > Don't do it in the kernel. It has nothing to gcc version.
> 
> Addition and subtraction works fine. The problem is with multiplication
> and division. I am doing this to avoid floating point calculation and
> doing fixed point calculation. The rage is large enough to need "long
> long" Any other way to achieve this?

	How arbitrary is the divisor ?
	Not by change a power-of-two ?

	If it is arbitrary, how large ?
	The printk() contains support routine doing  longlong/int
	division when a) speed is *not* important, b) divisor is
	sufficiently small, and I think c) divisor is positive.

	When you look at that code, you should begin to grasp,
	what kind of monster is the longlong/longlong code at -lgcc ...
	(and why gcc doesn't produce inline code for it.)

> thanks
> manoj

/Matti Aarnio
