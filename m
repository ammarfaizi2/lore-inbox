Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751768AbWB0WaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbWB0WaW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbWB0WaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:30:22 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:39568 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751768AbWB0WaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:30:21 -0500
Date: Mon, 27 Feb 2006 14:30:02 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@muc.de>
cc: Andrew Morton <akpm@osdl.org>, largret@gmail.com,
       76306.1226@compuserve.com, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: OOM-killer too aggressive?
In-Reply-To: <20060226235142.GB91959@muc.de>
Message-ID: <Pine.LNX.4.64.0602271429270.12204@schroedinger.engr.sgi.com>
References: <200602260938_MC3-1-B94B-EE2B@compuserve.com>
 <20060226102152.69728696.akpm@osdl.org> <1140988015.5178.15.camel@shogun.daga.dyndns.org>
 <20060226133140.4cf05ea5.akpm@osdl.org> <20060226235142.GB91959@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Feb 2006, Andi Kleen wrote:

> Thinking about this more I think we need a __GFP_NOOOM for other
> purposes too. e.g. the x86-64 IOMMU code tries to do similar
> fallbacks and I suspect it will be hit by the OOM killer too.

Isnt this also a constrained allocation? We could expand the check to also 
catch these types of restrictions and fail.

