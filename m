Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWEOXrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWEOXrs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWEOXrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:47:48 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:27066 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1750806AbWEOXrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:47:47 -0400
X-IronPort-AV: i="4.05,131,1146466800"; 
   d="scan'208"; a="277215701:sNHT1761662948"
To: ralphc@pathscale.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 53 of 53] ipath - add memory  barrier when waiting for writes
X-Message-Flag: Warning: May contain useful information
References: <f8ebb8c1e43635081b73.1147477418@eng-12.pathscale.com>
	<adazmhjth56.fsf@cisco.com>
	<1147727447.2773.14.camel@chalcedony.pathscale.com>
	<60844.71.131.57.117.1147734080.squirrel@rocky.pathscale.com>
	<ada64k6sx7w.fsf@cisco.com>
	<40771.71.131.57.117.1147735500.squirrel@rocky.pathscale.com>
	<adaslnarhpv.fsf@cisco.com>
	<53739.71.131.57.117.1147736281.squirrel@rocky.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 15 May 2006 16:47:41 -0700
In-Reply-To: <53739.71.131.57.117.1147736281.squirrel@rocky.pathscale.com> (ralphc@pathscale.com's message of "Mon, 15 May 2006 16:38:01 -0700 (PDT)")
Message-ID: <adafyjargte.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 May 2006 23:47:42.0666 (UTC) FILETIME=[F53142A0:01C67879]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    ralphc> I didn't try calling barrier() so I don't know the answer.
    ralphc> When power is restored, I can try it.  My guess is that
    ralphc> it's a timing issue and not a code reordering issue.

Hmm, then we really better understand what's going on, because
otherwise you're just going to have trouble again if someone makes a
CPU with a faster mfence instruction...
