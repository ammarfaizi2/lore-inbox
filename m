Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752438AbWAFIuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438AbWAFIuH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 03:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752435AbWAFIuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 03:50:07 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:4510 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1752438AbWAFIuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 03:50:05 -0500
Date: Fri, 6 Jan 2006 16:58:59 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH 09/16] mm: remove unnecessary variable and loop
Message-ID: <20060106085859.GD5297@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Christoph Lameter <christoph@lameter.com>,
	Rik van Riel <riel@redhat.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
	Andrea Arcangeli <andrea@suse.de>
References: <20051207104755.177435000@localhost.localdomain> <20051207105106.887005000@localhost.localdomain> <20060105192156.GA12589@dmt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105192156.GA12589@dmt.cnet>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 05:21:56PM -0200, Marcelo Tosatti wrote:
> On Wed, Dec 07, 2005 at 06:48:04PM +0800, Wu Fengguang wrote:
> > shrink_cache() and refill_inactive_zone() do not need loops.
> > 
> > Simplify them to scan one chunk at a time.
> 
> Hi Wu,

Hi Marcelo,

> What is the purpose of scanning large chunks at a time?

But I did not say or mean 'large' chunks :)
With the patch the chunk size is _always_ set to SWAP_CLUSTER_MAX=32 - the good
old default value.

Thanks.
Wu
