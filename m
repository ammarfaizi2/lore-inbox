Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262260AbUKQKok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbUKQKok (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 05:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbUKQKok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 05:44:40 -0500
Received: from aun.it.uu.se ([130.238.12.36]:34031 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262260AbUKQKnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 05:43:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16795.11086.38315.444645@alkaid.it.uu.se>
Date: Wed, 17 Nov 2004 11:43:26 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: RE: [patch] prefer TSC over PM Timer
In-Reply-To: <Pine.LNX.4.61.0411161738370.13681@twinlark.arctic.org>
References: <88056F38E9E48644A0F562A38C64FB60035C613D@scsmsx403.amr.corp.intel.com>
	<Pine.LNX.4.61.0411161738370.13681@twinlark.arctic.org>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet writes:
 > On Tue, 16 Nov 2004, Pallipadi, Venkatesh wrote:
 > 
 > > I think trying to remove repeated inl()'s in read_pmtmr is a better 
 > > fix for this issue. As John mentioned in other thread, we should do 
 > > repeated reads only when something looks broken. Not always.
 > 
 > that would be a nice improvement... then timer_pm will only be 3x as slow 
 > as timer_tsc instead of 10x slower :)  it's still a lot of unnecessary 
 > overhead for many systems, and unfortunately this is a real performance 
 > problem (albeit exaggerated by code which is overzealous in its use of 
 > gettimeofday()).
 > 
 > on a tangent... has the local apic timer ever been considered?  it's fixed 
 > rate, and my measurements show it in the same performance ballpark as TSC.
 > 
 > i know that all p3, p-m, p4, k8 and efficeon have local APIC, but i'm not 
 > sure if k7 (other than k7 smp parts of course) have local apics... so i'm 
 > not sure how widespread it is compared to pm-timer.

All K7/K8s except the very first K7 Model 1 have local APICs.
There is no difference between UP and MP parts in this respect.

/Mikael
