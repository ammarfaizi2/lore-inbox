Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWEOX20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWEOX20 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWEOX20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:28:26 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:5934 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1750763AbWEOX2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:28:25 -0400
X-IronPort-AV: i="4.05,131,1146466800"; 
   d="scan'208"; a="1806701922:sNHT50238558"
To: ralphc@pathscale.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 53 of 53] ipath - add memory barrier when waiting for writes
X-Message-Flag: Warning: May contain useful information
References: <f8ebb8c1e43635081b73.1147477418@eng-12.pathscale.com>
	<adazmhjth56.fsf@cisco.com>
	<1147727447.2773.14.camel@chalcedony.pathscale.com>
	<60844.71.131.57.117.1147734080.squirrel@rocky.pathscale.com>
	<ada64k6sx7w.fsf@cisco.com>
	<40771.71.131.57.117.1147735500.squirrel@rocky.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 15 May 2006 16:28:12 -0700
In-Reply-To: <40771.71.131.57.117.1147735500.squirrel@rocky.pathscale.com> (ralphc@pathscale.com's message of "Mon, 15 May 2006 16:25:00 -0700 (PDT)")
Message-ID: <adaslnarhpv.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 May 2006 23:28:18.0559 (UTC) FILETIME=[3F54A0F0:01C67877]
Authentication-Results: sj-dkim-4.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    ralphc> We had a power failure here so I'm not able to reproduce
    ralphc> the assembly code at the moment.  What I remember from
    ralphc> looking at the code is that the code for
    ralphc> ipath_read_kreg32() was present in i2c_wait_for_writes()
    ralphc> when compiled -Os so it didn't look like a compiler bug.
    ralphc> I probably could put the mb() at the end of i2c_gpio_set()
    ralphc> if that makes you more comfortable.  The mb() is
    ralphc> definitely needed though.

Is it the mb()?  Or is just a barrier() enough?  In other words do you
really need the mfence, or do you just need to stop the compiler from
reordering things?

 - R.
