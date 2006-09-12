Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965224AbWILAys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224AbWILAys (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 20:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbWILAys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 20:54:48 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:61226 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S965224AbWILAyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 20:54:47 -0400
To: David Miller <davem@davemloft.net>
Cc: segher@kernel.crashing.org, jbarnes@virtuousgeek.org, jeff@garzik.org,
       paulus@samba.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org, akpm@osdl.org
Subject: Re: Opinion on ordering of writel vs. stores to RAM
X-Message-Flag: Warning: May contain useful information
References: <D680AFCF-11EC-48AD-BBC2-B92521DF442A@kernel.crashing.org>
	<20060911.062144.74719116.davem@davemloft.net>
	<8DA3BCBF-0F19-4CF0-B22E-91E57E7CB033@kernel.crashing.org>
	<20060911.173208.74750403.davem@davemloft.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 11 Sep 2006 17:54:44 -0700
In-Reply-To: <20060911.173208.74750403.davem@davemloft.net> (David Miller's message of "Mon, 11 Sep 2006 17:32:08 -0700 (PDT)")
Message-ID: <adaejuh3nvv.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 12 Sep 2006 00:54:46.0441 (UTC) FILETIME=[0AB4D990:01C6D606]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> It's silly because if you just use different interface
    David> names for the different semantics, the caller can ask for
    David> what he wants at the call site and no conditionals are
    David> needed in the implementation.

OTOH that leads to a combinatorial explosion of 8/16/32/64 access
sizes, write combining or not, strongly ordered wrt local memory or
not, relaxed PCI ordering or not, etc. etc.

 - R.
