Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266712AbSLDQBG>; Wed, 4 Dec 2002 11:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266717AbSLDQBG>; Wed, 4 Dec 2002 11:01:06 -0500
Received: from postino2.roma1.infn.it ([141.108.26.25]:52389 "EHLO
	postino2.roma1.infn.it") by vger.kernel.org with ESMTP
	id <S266712AbSLDQBF>; Wed, 4 Dec 2002 11:01:05 -0500
Date: Wed, 4 Dec 2002 17:08:55 +0100 (CET)
From: "davide.rossetti" <Davide.Rossetti@roma1.infn.it>
Reply-To: davide.rossetti@roma1.infn.it
To: Madhavi <madhavis@sasken.com>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: in_irq()
In-Reply-To: <Pine.LNX.4.33.0212031122460.2995-100000@pcz-madhavis.sasken.com>
Message-ID: <Pine.LNX.4.44.0212041707290.3422-100000@ronin.ape>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-RAVMilter-Version: 8.3.1(snapshot 20020108) (postino2.roma1.infn.it)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Dec 2002, Madhavi wrote:

> 
> Hi
> 
> I am using a UP system with CONFIG_SMP=y in .config with linux 2.4.19
> kernel.
> 
> I have this piece of code:
> 
> 	spin_lock_irqsave(&some_lock, flags);
> 	in_irq();
> 	spin_unlock_irqrestore(&some_lock, flags);
> 
> I have read somewhere (I think its given in the Unreliable Guide to
> kernel locking) that in_irq() returns true when the interrupts
> are blocked. So, I was expecting in_irq() to return true here. But, it is
> returning 0 here.

I think it is intended to return true only if you are in an interrupt 
context.... that is in the context of a iterrupt handler...

ciao


-- 
______/ Rossetti Davide   INFN - Roma I - APE group \______________
 pho +390649914507/412   web: http://apegate.roma1.infn.it/~rossetti
 fax +390649914423     email: davide.rossetti@roma1.infn.it        


