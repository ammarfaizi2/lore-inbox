Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbUCUBKa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 20:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUCUBKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 20:10:30 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:64398 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S262984AbUCUBK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 20:10:29 -0500
Date: Sun, 21 Mar 2004 02:09:39 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Peter Williams <peterw@aurema.com>
cc: Arjan van de Ven <arjanv@redhat.com>,
       Stefan Smietanowski <stesmi@stesmi.com>,
       Micha Feigin <michf@post.tau.ac.il>, John Reiser <jreiser@BitWagon.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
In-Reply-To: <405CDAAD.5020308@aurema.com>
Message-ID: <Pine.LNX.4.53.0403210202120.24035@gockel.physik3.uni-rostock.de>
References: <20040311141703.GE3053@luna.mooo.com> <1079198671.4446.3.camel@laptop.fenrus.com>
 <4053624D.6080806@BitWagon.com> <20040313193852.GC12292@devserv.devel.redhat.com>
 <40564A22.5000504@aurema.com> <20040316063331.GB23988@devserv.devel.redhat.com>
 <40578FDB.9060000@aurema.com> <20040320102241.GK2803@devserv.devel.redhat.com>
 <405C2AC0.70605@stesmi.com> <20040320114112.GA29102@devserv.devel.redhat.com>
 <405CDAAD.5020308@aurema.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Mar 2004, Peter Williams wrote:

> In the 2.6 kernels internal timing and task statistics (for i386 
> systems) are now kept in milliseconds where they were previously in 
> 1/100ths of a second.  By converting these statistics to 1/100ths of a 
> second for export to user space an order of magnitude (i.e. a factor of 
> 10) loss of precision occurs.

No. The statistics are not a result of full bookkeeping, but simply
gained by periodically sampling the processor state. So they don't
have a precision of 1/1000th of a second anyways.


Tim
