Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264256AbUHTIG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbUHTIG5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 04:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbUHTIG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:06:56 -0400
Received: from mx2.elte.hu ([157.181.151.9]:53378 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264256AbUHTIF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:05:57 -0400
Date: Fri, 20 Aug 2004 10:06:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       John Hawkes <hawkes@sgi.com>
Subject: Re: [PATCH] add scheduler domains for ia64
Message-ID: <20040820080621.GA2310@elte.hu>
References: <200408131108.40502.jbarnes@engr.sgi.com> <200408171657.32357.jbarnes@engr.sgi.com> <41255DBA.3030909@yahoo.com.au> <200408192222.35512.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408192222.35512.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jesse Barnes <jbarnes@engr.sgi.com> wrote:

> This patch adds some more NUMA specific logic to the creation of
> scheduler domains.  Domains spanning all CPUs in a large system are
> too large to schedule across efficiently, leading to livelocks and
> inordinate amounts of time being spent in scheduler routines.  With
> this patch applied, the node scheduling domains for NUMA platforms
> will only contain a specified number of nearby CPUs, based on the
> value of SD_NODES_PER_DOMAIN.  It also allows arches to override
> SD_NODE_INIT, which sets the domain scheduling parameters for each
> node's domain.  This is necessary especially for large systems.

looks good to me too.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

	Ingo
