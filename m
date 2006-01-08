Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752658AbWAHSCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbWAHSCZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 13:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752659AbWAHSCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 13:02:25 -0500
Received: from [139.30.44.16] ([139.30.44.16]:54587 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1752658AbWAHSCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 13:02:24 -0500
Date: Sun, 8 Jan 2006 19:02:23 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Valdis.Kletnieks@vt.edu
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Michael Buesch <mbuesch@freenet.de>,
       arjan@infradead.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1/4] move capable() to capability.h 
In-Reply-To: <200601080745.k087j3mU016114@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.63.0601081853020.6962@gockel.physik3.uni-rostock.de>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org>
 <200601061218.17369.mbuesch@freenet.de> <1136546539.2940.28.camel@laptopd505.fenrus.org>
 <200601061226.42416.mbuesch@freenet.de>            <20060107215106.38d58bb9.rdunlap@xenotime.net>
 <200601080745.k087j3mU016114@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2006, Valdis.Kletnieks@vt.edu wrote:

> On Sat, 07 Jan 2006 21:51:06 PST, "Randy.Dunlap" said:
> 
> > From: Randy Dunlap <rdunlap@xenotime.net>
> > 
> > headers + core:
> > - Move capable() from sched.h to capability.h;
> > - Use <linux/capability.h> where capable() is used
> > 	(in include/, block/, ipc/, kernel/, a few drivers/,
> > 	mm/, security/, & sound/;
> > 	many more drivers/ to go)
> 
> Are there plans for a second patch series to remove sched.h from those
> files that only needed it for capable()?

Yes. I've written a set of (horrendously inefficient, but working) scripts 
that detect whenever sched.h isn't needed in a file anymore.
So I think it's ok if Randy just leaves the dangling references to 
sched.h, I will clean them up afterwards.

I recently stopped posting patches because I will be offline for a month 
or two and thus unable to look after problems that these patches might 
cause. I hope to resume operation in March.

Tim
