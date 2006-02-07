Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWBGRMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWBGRMO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWBGRMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:12:14 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:16047 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932163AbWBGRMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:12:12 -0500
Date: Tue, 7 Feb 2006 09:11:53 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Ingo Molnar <mingo@elte.hu>, steiner@sgi.com, Paul Jackson <pj@sgi.com>,
       akpm@osdl.org, dgc@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
In-Reply-To: <200602071523.20174.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0602070911050.24623@schroedinger.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
 <200602071414.31119.ak@suse.de> <20060207141141.GA14706@elte.hu>
 <200602071523.20174.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2006, Andi Kleen wrote:

> > are you sure this is not some older VM issue? 
> 
> Unless you implement page migration for all caches it's still there.
> The only way to get rid of caches on a node currently is to throw them
> away.  And refetching them from disk is quite costly.

The caches on a node are shrunk dynamically see the zone_reclaim 
functionality introduced in 2.6.16-rc2.
