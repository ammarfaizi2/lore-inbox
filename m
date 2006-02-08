Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030613AbWBHXaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030613AbWBHXaV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 18:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030615AbWBHXaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 18:30:21 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:63655 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030613AbWBHXaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 18:30:20 -0500
Date: Wed, 8 Feb 2006 15:29:59 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@osdl.org>, pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Terminate process that fails on a constrained allocation
In-Reply-To: <200602082341.02243.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0602081529160.5184@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com>
 <20060208133909.183f19ea.akpm@osdl.org> <Pine.LNX.4.62.0602081402310.4735@schroedinger.engr.sgi.com>
 <200602082341.02243.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006, Andi Kleen wrote:

> Unfortunately Andrew's point with the GFP_NOFS still applies :/
> But I would consider any caller of this not handling NULL be broken.
> Andrew do you have any stronger evidence it's a real problem?

I would think that a caller will have to set __GFP_NOFAIL if a NULL is 
unacceptable.
