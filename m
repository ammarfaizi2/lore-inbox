Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbTEESQE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 14:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbTEESQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 14:16:04 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:19106 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261201AbTEESQC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 14:16:02 -0400
Date: Mon, 5 May 2003 11:28:27 -0700
From: Greg KH <greg@kroah.com>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: linux-i2c@pelican.tk.uni-linz.ac.at, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69: Tyans S2460 hang with i2c
Message-ID: <20030505182827.GB1826@kroah.com>
References: <20030505114246.GA673@gallifrey> <20030505175030.GB1713@kroah.com> <20030505181831.GF673@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030505181831.GF673@gallifrey>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 07:18:31PM +0100, Dr. David Alan Gilbert wrote:
> * Greg KH (greg@kroah.com) wrote:
> > On Mon, May 05, 2003 at 12:42:46PM +0100, Dr. David Alan Gilbert wrote:
> > > Kernel: 2.5.69
> > > Motherboard: Tyan S2460 (Dual Athlon 760MP chipset)
> > > 
> > > It works fine without i2c, with i2c we hang directly after:
> > > 
> > > i2c /dev entries module version 2.7.0 (20021208)
> > > registering 0-0048
> > 
> > What i2c drivers are you trying to load?  Are you sure you have the
> > hardware for them?  Some of the i2c sensor drivers can hang your box if
> > you load them and you don't have the hardware for them.
> 
> Looking back at the objects that were built they are:
> 
> ./busses/i2c-amd756.o
> ./chips/adm1021.o
> ./chips/lm75.o
> 
> I guess its a bad thing if they hang if the hardware isn't present - I'd
> presumed it was possible to build them all and they'd just use which
> ever are actually present. (How do I know which I've got?)

I'd recommend running 2.4 and getting the latest i2c and lmsensors code
from the lmsensors web site.  Then run the sensors-detect script which
will try to safely determine what kind of hardware you have, and what
drivers you need.

If after doing that, it says you have the adm1021 and lm75 chips and
they work properly on 2.4, please let me know and I'll try to track down
what's changed on 2.5.

Hope this helps,

greg k-h
