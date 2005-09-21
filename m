Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbVIUP0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbVIUP0p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 11:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbVIUP0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 11:26:45 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:3499 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751078AbVIUP0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 11:26:44 -0400
Date: Wed, 21 Sep 2005 08:26:28 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Frank van Maarseveen <frankvm@frankvm.com>, linux-kernel@vger.kernel.org,
       jlan@sgi.com
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
In-Reply-To: <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.62.0509210824350.10125@schroedinger.engr.sgi.com>
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2005, Hugh Dickins wrote:

> On Wed, 21 Sep 2005, Frank van Maarseveen wrote:
> > This fixes a post 2.6.11 regression in maintaining the mm->hiwater_* counters.
> 
> It would be a good idea to CC Christoph Lameter, who I believe was the
> one who very intentionally moved most of these updates out to timer tick.

Right and we need to include Jay who introduced these in the first place.

What is the reason to move these counters back into the performance 
critical vm paths? We agreed that some inaccuracy in these numbers was 
acceptable.

