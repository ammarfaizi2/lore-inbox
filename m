Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265797AbRGCAyg>; Mon, 2 Jul 2001 20:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265926AbRGCAy1>; Mon, 2 Jul 2001 20:54:27 -0400
Received: from stm.lbl.gov ([131.243.16.51]:12301 "EHLO stm.lbl.gov")
	by vger.kernel.org with ESMTP id <S265797AbRGCAyR>;
	Mon, 2 Jul 2001 20:54:17 -0400
Date: Mon, 2 Jul 2001 17:54:12 -0700
From: David Schleef <ds@schleef.org>
To: David T Eger <eger@cc.gatech.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: readl() / writel() on PowerPC
Message-ID: <20010702175412.A15774@stm.lbl.gov>
Reply-To: David Schleef <ds@schleef.org>
In-Reply-To: <Pine.SOL.4.21.0106180852480.16027-100000@oscar.cc.gatech.edu> <Pine.SOL.4.21.0107022017370.23357-100000@oscar.cc.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SOL.4.21.0107022017370.23357-100000@oscar.cc.gatech.edu>; from eger@cc.gatech.edu on Mon, Jul 02, 2001 at 08:22:55PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2001 at 08:22:55PM -0400, David T Eger wrote:
> 
> I have been working on a driver for a PowerPC PCI card/framebuffer device,
> and noticed that the standard readl() and writel() for this platform to
> byte swapping, since PowerPC runs big-endian.  However, at least for my
> hardware it's *really* not needed, and should just do a regular load
> store, as is done for CONFIG_APUS.  Looking at another driver
> (drivers/char/bttv.h) I notice that Mr. Metzler redefines his read and
> write routines for PowerPC as well to do simple loads and stores to IO
> regions.


I believe you are looking for __raw_readl(), __raw_writel().



dave...

