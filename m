Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130031AbRBQTIx>; Sat, 17 Feb 2001 14:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129612AbRBQTIn>; Sat, 17 Feb 2001 14:08:43 -0500
Received: from beamer.mchh.siemens.de ([194.138.158.163]:15044 "EHLO
	beamer.mchh.siemens.de") by vger.kernel.org with ESMTP
	id <S130031AbRBQTIa>; Sat, 17 Feb 2001 14:08:30 -0500
From: "Thomas Widmann" <thomas.widmann@icn.siemens.de>
To: <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <andrewm@uow.edu.au>
Subject: Re: SMP: bind process to cpu
Date: Sat, 17 Feb 2001 20:08:08 +0100
Message-ID: <BGEDIODHBENLENEMBEPAIEDFCAAA.thomas.widmann@icn.siemens.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <3A8E8C8F.A2A9E69E@uow.edu.au>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Andrew Morton wrote:

> > Hi,
> > 
> > I run an 3*XEON 550MHz Primergy with 2GB of RAM.
> > On this machine, i have compiled kernel 2.4.0SMP.
> > 
> > Is it possible to bind a process to a specific
> > cpu on this SMP machine (process affinity) ?
> > 
> > I there something like pset ?
> 
> A patch which creates /proc/<pid>/cpus_allowed is at
> 
> 	http://www.uow.edu.au/~andrewm/linux/#cpus_allowed
> 
> You just write a bitmask into it.

Thanks for this information. I patched my the kernel with it.
After rebooting with the new kernel i can see the bitmask
for every process running on my server.

#cat /proc/1310/cpus_allowed
ffffffff

Now, if i want to run this process on only one cpu, i which way
do i have to set the bitmask ?
Let's say, i want to run it on cpu0. how look's the bitmask ?

Thanks 

Regards
Thomas
