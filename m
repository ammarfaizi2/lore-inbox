Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWEOXe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWEOXe7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWEOXe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:34:59 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:60771 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1750783AbWEOXe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:34:58 -0400
X-IronPort-AV: i="4.05,131,1146466800"; 
   d="scan'208"; a="277208407:sNHT30854808"
To: Grant Grundler <iod00d@hp.com>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 21 of 53] ipath - use phys_to_virt instead of bus_to_virt
X-Message-Flag: Warning: May contain useful information
References: <4e0a07d20868c6c4f038.1147477386@eng-12.pathscale.com>
	<adad5efuw1o.fsf@cisco.com>
	<1147728081.2773.25.camel@chalcedony.pathscale.com>
	<adar72vrn8y.fsf@cisco.com> <20060515231342.GK29082@esmail.cup.hp.com>
	<ada1wuuswte.fsf@cisco.com> <20060515233049.GM29082@esmail.cup.hp.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 15 May 2006 16:34:56 -0700
In-Reply-To: <20060515233049.GM29082@esmail.cup.hp.com> (Grant Grundler's message of "Mon, 15 May 2006 16:30:49 -0700")
Message-ID: <adak68mrhen.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 May 2006 23:34:57.0275 (UTC) FILETIME=[2CFBDCB0:01C67878]
Authentication-Results: sj-dkim-4.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Grant> Aren't remote addresses handled differently than local
    Grant> ones?  ULP has to map local addresses.  We can't map remote
    Grant> ones (remote host maps it).  The ULP must know the
    Grant> difference and can tell the lower level driver which is
    Grant> which.

The problem is that RDMA requests have to be handled by the low-level
driver (or hardware) without any ULP involvement.  So every device has
to handle getting messages like "send me XXX bytes of data from
address YYY in the memory region corresponding to R_Key ZZZ."

 - R.
