Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbTEESGG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 14:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbTEESGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 14:06:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60355 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261181AbTEESGC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 14:06:02 -0400
Date: Mon, 5 May 2003 19:18:31 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Greg KH <greg@kroah.com>
Cc: linux-i2c@pelican.tk.uni-linz.ac.at, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69: Tyans S2460 hang with i2c
Message-ID: <20030505181831.GF673@gallifrey>
References: <20030505114246.GA673@gallifrey> <20030505175030.GB1713@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030505175030.GB1713@kroah.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.5.69 (i686)
X-Uptime: 19:16:41 up  6:39,  1 user,  load average: 0.00, 0.02, 0.00
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (greg@kroah.com) wrote:
> On Mon, May 05, 2003 at 12:42:46PM +0100, Dr. David Alan Gilbert wrote:
> > Kernel: 2.5.69
> > Motherboard: Tyan S2460 (Dual Athlon 760MP chipset)
> > 
> > It works fine without i2c, with i2c we hang directly after:
> > 
> > i2c /dev entries module version 2.7.0 (20021208)
> > registering 0-0048
> 
> What i2c drivers are you trying to load?  Are you sure you have the
> hardware for them?  Some of the i2c sensor drivers can hang your box if
> you load them and you don't have the hardware for them.

Looking back at the objects that were built they are:

./busses/i2c-amd756.o
./chips/adm1021.o
./chips/lm75.o

I guess its a bad thing if they hang if the hardware isn't present - I'd
presumed it was possible to build them all and they'd just use which
ever are actually present. (How do I know which I've got?)

> And has these i2c drivers ever worked for you before on an older version
> of 2.5?

Hmm - its a while since I last tried it I think; I'm reasonably sure
I've had some working in the past).

Dave

 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
