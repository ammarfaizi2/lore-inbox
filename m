Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUCKJZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 04:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262977AbUCKJZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 04:25:55 -0500
Received: from dirac.phys.uwm.edu ([129.89.57.19]:57996 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S262772AbUCKJZj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 04:25:39 -0500
Date: Thu, 11 Mar 2004 03:25:33 -0600 (CST)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
cc: Henrik Persson <nix@syndicalist.net>, linux-kernel@vger.kernel.org
Subject: Re: Strange DMA-errors and system hang with Promise 20268
In-Reply-To: <20040310154137.GC31893@darkside.22.kls.lan>
Message-ID: <Pine.GSO.4.21.0403110321090.11871-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Mar 10, 2004 at 05:50:12AM -0600, Bruce Allen wrote:
> > > > I suspect it having something to do with 2.4.25 new "One last
> > > > read after the timeout" in ide-iops.c and accessing the drive
> > > > while selftest running (possibly especially short selftest).
> > Does the disk's SMART error log (smartctl -l error) show any entries
> 
> Just in addition, to point this out more clearly:
> I personally don't suspect smartmontools having some
> problem.
> I run debians smartmontools package since a long time
> and it does the selftests a long time as well. It never
> had problems with it, it wasnt updated close to first
> occurence of the problem or changed in any other way.
> I have 4 disks, 2 on the onboard VIA controller, 2 on
> the Promise. The problem always occured on the Promise
> (like Henrik pointed too) disk.
> I more suspect any kernel ide <-> promise-driver timing
> problem. Maybe smartmontools makes it more possibe that
> this timing problem occurs, maybe not (with Henriks
> answer to my question I rather favorite the 'maybe not'),
> maybe it's even just some load issue making the problem
> occur.

OK, thanks for the reassurance.  There have been some warnings about
promise 20262 and 20265 controllers interacting badly with smartmontools
(locking up systems).  See
http://cvs.sourceforge.net/viewcvs.py/smartmontools/sm5/WARNINGS?view=markup
Perhaps this is in some way related.

Cheers,
	Bruce

