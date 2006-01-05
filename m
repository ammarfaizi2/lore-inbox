Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWAENdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWAENdX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 08:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWAENdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 08:33:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23499 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751137AbWAENdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 08:33:22 -0500
Date: Thu, 5 Jan 2006 08:32:19 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>
Subject: Re: [PATCH 6/9] clockpro-clockpro.patch
In-Reply-To: <20060105094722.897C574030@sv1.valinux.co.jp>
Message-ID: <Pine.LNX.4.63.0601050830530.18976@cuia.boston.redhat.com>
References: <20051230223952.765.21096.sendpatchset@twins.localnet>
 <20051230224312.765.58575.sendpatchset@twins.localnet> <20051231002417.GA4913@dmt.cnet>
 <1136028546.17853.69.camel@twins> <20060105094722.897C574030@sv1.valinux.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2006, IWAMOTO Toshihiro wrote:

> Is it okay to allow Hcold to lap Hhot?

I think it should be fine for Hcold to overtake Hhot, or
the other way around.

> In my understanding of CLOCK-Pro, such lapping causes sudden increase
> in the distance between Hhot and Hcold.  As that distance is an
> important parameter of page aging/replacement decisions, I'm afraid
> that such lapping would result in incorrect page aging and bad
> performance.

Hcold only manipulates cold pages, Hhot only manipulates hot
pages and the test bit on cold pages.  Having one hand overtake
the other should not disturb things at all, since they both do
something different.

-- 
All Rights Reversed
