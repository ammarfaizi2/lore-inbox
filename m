Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUAMX0G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 18:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266280AbUAMX0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 18:26:06 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:48777
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S266274AbUAMX0D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 18:26:03 -0500
Date: Tue, 13 Jan 2004 18:38:06 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Arjan van de Ven <arjanv@redhat.com>, Scott Long <scott_long@adaptec.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Proposed enhancements to MD
Message-ID: <20040113183806.A16839@animx.eu.org>
References: <40033D02.8000207@adaptec.com> <1074031592.4981.1.camel@laptop.fenrus.com> <20040113174422.B16728@animx.eu.org> <40047AA6.4020200@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <40047AA6.4020200@domdv.de>; from Andreas Steinmetz on Wed, Jan 14, 2004 at 12:09:26AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > As I've understood it, the configuration for DM is userspace and the kernel
> > can't do any auto detection.  This would be a "put off" for me to use as a
> > root filesystem.  Configurations like this (and lvm too last I looked at it)
> > require an initrd or some other way of setting up the device.  Unfortunately
> > this means that there's configs in 2 locations (one not easily available,  if
> > using initrd.  easily != mounting via loop!)
> 
> You can always do the following: use a mini root fs on the partition 
> where the kernel is located that does nothing but vgscan and friends and 
> then calls pivot_root. '/sbin/init' of the mini root fs looks like:

What is the advantage of not putting the autodetector/setup in the kernel? 
Not everyone is going to use this software (or am I wrong on that?) so that
can be left as an option to compile in (or as a module if possible and if
autodetection is not required).  How much work is it to maintain something
like this in the kernel?

I ask because I'm not a kernel hacker, mostly an end user  (atleast I can
compile my own kernels =)

I must say, the day that kernel level ip configuration via bootp is removed
I'm going to be pissed =)

I like the fact that MD can autodetect raids on boot when compiled in, I
didn't like the fact it can't be partitioned.  That's the only thing that
put me off with MD.  LVM put me off because it couldn't be auto detected at
boot.  I was going to play with DM, but I haven't yet.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
