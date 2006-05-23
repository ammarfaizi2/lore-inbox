Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWEWVbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWEWVbH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 17:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWEWVbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 17:31:07 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:48163 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S932288AbWEWVbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 17:31:05 -0400
X-IronPort-AV: i="4.05,161,1146466800"; 
   d="scan'208"; a="1811542407:sNHT267404500"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 1 of 10] ipath - fix spinlock recursion bug
X-Message-Flag: Warning: May contain useful information
References: <bc968dacc8608566f4d2.1148409149@eng-12.pathscale.com>
	<adawtccqwhg.fsf@cisco.com>
	<1148419611.22550.11.camel@chalcedony.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 23 May 2006 14:31:00 -0700
In-Reply-To: <1148419611.22550.11.camel@chalcedony.pathscale.com> (Bryan O'Sullivan's message of "Tue, 23 May 2006 14:26:51 -0700")
Message-ID: <adasln0qvhn.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 23 May 2006 21:31:03.0868 (UTC) FILETIME=[31A1F7C0:01C67EB0]
Authentication-Results: sj-dkim-4.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> How do you feel about taking one code motion patch for
    Bryan> 2.6.17?  :-)

It's probably OK as long as it's pure code motion.  In other words
separate the actual fixes from moving code around.  What I want to
avoid is the giant combo patch that does several different things,
because if someone later bisects a regression back to that patch,
we're kind of screwed...

 - R.
