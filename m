Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbUCJPmY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 10:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbUCJPmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 10:42:24 -0500
Received: from piggy.rz.tu-ilmenau.de ([141.24.4.8]:14056 "EHLO
	piggy.rz.tu-ilmenau.de") by vger.kernel.org with ESMTP
	id S262694AbUCJPlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 10:41:45 -0500
Date: Wed, 10 Mar 2004 16:41:37 +0100
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
To: Bruce Allen <ballen@gravity.phys.uwm.edu>
Cc: Henrik Persson <nix@syndicalist.net>, linux-kernel@vger.kernel.org
Subject: Re: Strange DMA-errors and system hang with Promise 20268
Message-ID: <20040310154137.GC31893@darkside.22.kls.lan>
Mail-Followup-To: Mario 'BitKoenig' Holbe <Mario.Holbe@RZ.TU-Ilmenau.DE>,
	Bruce Allen <ballen@gravity.phys.uwm.edu>,
	Henrik Persson <nix@syndicalist.net>, linux-kernel@vger.kernel.org
References: <1078752642.1239.14.camel@vega> <Pine.GSO.4.21.0403100547430.8400-100000@dirac.phys.uwm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0403100547430.8400-100000@dirac.phys.uwm.edu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 05:50:12AM -0600, Bruce Allen wrote:
> > > I suspect it having something to do with 2.4.25 new "One last
> > > read after the timeout" in ide-iops.c and accessing the drive
> > > while selftest running (possibly especially short selftest).
> Does the disk's SMART error log (smartctl -l error) show any entries

Just in addition, to point this out more clearly:
I personally don't suspect smartmontools having some
problem.
I run debians smartmontools package since a long time
and it does the selftests a long time as well. It never
had problems with it, it wasnt updated close to first
occurence of the problem or changed in any other way.
I have 4 disks, 2 on the onboard VIA controller, 2 on
the Promise. The problem always occured on the Promise
(like Henrik pointed too) disk.
I more suspect any kernel ide <-> promise-driver timing
problem. Maybe smartmontools makes it more possibe that
this timing problem occurs, maybe not (with Henriks
answer to my question I rather favorite the 'maybe not'),
maybe it's even just some load issue making the problem
occur.


Mario
-- 
<jv> Oh well, config
<jv> one actually wonders what force in the universe is holding it
<jv> and makes it working
<Beeth> chances and accidents :)
