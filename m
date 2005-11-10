Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbVKJVnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbVKJVnV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 16:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbVKJVnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 16:43:21 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:63926 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932163AbVKJVnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 16:43:18 -0500
Date: Thu, 10 Nov 2005 13:43:12 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Hugh Dickins <hugh@veritas.com>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/15] mm: atomic64 page counts
In-Reply-To: <20051109190135.45e59298.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0511101342340.16283@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0511100156320.5814@goblin.wat.veritas.com>
 <20051109181641.4b627eee.akpm@osdl.org> <Pine.LNX.4.61.0511100224030.6215@goblin.wat.veritas.com>
 <20051109190135.45e59298.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2005, Andrew Morton wrote:

> > I'm quite pleased with the way it's worked out, but you were intending
> > that the 64-bit arches should get along with 32-bit counts?  Maybe.
> 
> That seems reasonsable for file pages.  For the ZERO_PAGE the count can do
> whatever it wants, because we'd never free them up.

Frequent increments and decrements on the zero page count can cause a 
bouncing cacheline that may limit performance.

