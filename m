Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318349AbSIFHR5>; Fri, 6 Sep 2002 03:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318357AbSIFHR5>; Fri, 6 Sep 2002 03:17:57 -0400
Received: from dp.samba.org ([66.70.73.150]:52156 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S318349AbSIFHR4>;
	Fri, 6 Sep 2002 03:17:56 -0400
Date: Fri, 6 Sep 2002 16:48:41 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: paulus@au1.ibm.com, jamagallon@able.es, r.post@sara.nl,
       morten.helgesen@nextframe.net, linux-kernel@vger.kernel.org
Subject: Re: writing OOPS/panic info to nvram?
Message-Id: <20020906164841.3c7e1085.rusty@rustcorp.com.au>
In-Reply-To: <1031184421.2796.161.camel@irongate.swansea.linux.org.uk>
References: <E471FA7E-C00E-11D6-A20D-000393911DE2@sara.nl>
	<20020904140856.GA1949@werewolf.able.es>
	<1031149539.2788.120.camel@irongate.swansea.linux.org.uk>
	<15734.39068.766611.169333@argo.ozlabs.ibm.com>
	<1031184421.2796.161.camel@irongate.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 Sep 2002 01:07:01 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Thu, 2002-09-05 at 00:34, Paul Mackerras wrote:
> > IDE was relatively straightforward since you can do basic block I/O
> > with just the ATA-1 or ATA-2 registers and command set and PIO.  In
> > contrast, I believe SCSI defeated him. :)
> 
> You have to reset and retune the interface/controller registers as well,
> otherwise bad things can happen.

No, at this stage the code reboots the machine (well, I could call the ide
reset code at this point I guess).

Note that my mini oops dumper object file is a leafnode which doesn't use any
external code in the dump path (checked at build time).  It is armed with the
symbols and device & block offsets by userspace.  I plan to update it in the
next month, but it's trivial enough (a new driver with one hook in the oops
code) to be done after the freeze if reqd.

The interesting bit becomes harvesting those reports: this is a higher level
problem (userspace and privacy being the higher levels, respectively).

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
