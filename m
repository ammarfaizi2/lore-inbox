Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265329AbTIDSDR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265375AbTIDSCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:02:07 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:32161 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265386AbTIDSAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:00:23 -0400
Subject: RE: [PATCH] linux-2.6.0-test4_cyclone-hpet-fix_A0
From: john stultz <johnstul@us.ibm.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1902C7D23C@fmsmsx405.fm.intel.com>
References: <C8C38546F90ABF408A5961FC01FDBF1902C7D23C@fmsmsx405.fm.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1062698030.1315.1544.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 04 Sep 2003 10:53:50 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-04 at 10:21, Pallipadi, Venkatesh wrote:

> > Can we not we avoid the cut-n-paste coding?
> > 
> > There is also timer_tsc.c:calibrate_tsc_hpet() which is 
> > almost the same as
> > timer_hpet.c:calibrate_tsc().  Seem to me that we could tweak
> > calibrate_tsc_hpet() a bit, unstaticalise 
> > timer_tsc.c:calibrate_tsc() and
> > have two functions rather than four?
> > 
> 
> 
> How about the attached patch (against mm4), that moves all 
> calibrate tsc functions into a common file, avoiding the duplication. 
> This time I could successfully compile cyclone timer too :). However,

Looks better, any reason calibrate_tsc and calibrate_tsc_hpet can't be
unified (it looks like the same basic code just talking to different
hardware)? I was planning on giving that a shot later today.

> I had to do an unrelated one line change in fixmap (last chunk in 
> the patch) to compile for summit.

Is this just an -mm only thing (2.5 has _X86_CYCLONE_TIMER everywhere)?

thanks
-john




