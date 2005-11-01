Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbVKARWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbVKARWQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 12:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbVKARWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 12:22:16 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:23970 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750994AbVKARWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 12:22:15 -0500
Date: Tue, 1 Nov 2005 09:19:22 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: torvalds@osdl.org, kravetz@us.ibm.com, raybry@mpdtxmail.amd.com,
       linux-kernel@vger.kernel.org, lee.schermerhorn@hp.com,
       haveblue@us.ibm.com, magnus.damm@gmail.com, pj@sgi.com,
       marcelo.tosatti@cyclades.com, kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 0/5] Swap Migration V5: Overview
In-Reply-To: <20051031192506.100d03fa.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0511010916400.16157@schroedinger.engr.sgi.com>
References: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com>
 <20051031192506.100d03fa.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2005, Andrew Morton wrote:

> So I'll queue this up for -mm, but I think we need to see an entire
> hot-remove implementation based on this, and have all the interested
> parties signed up to it before we can start moving the infrastructure into
> mainline.

There are multiple components involved here. This includes user space, 
cpusets and kernel support for various forms of migrating pages.

> Do you think the features which these patches add should be Kconfigurable?

The policy layer stuff is already Kconfigurable via CONFIG_NUMA. 

I think the lower layer in vmscan.c could be always included since its 
currently small and its just a variation on swap. However, if we add the 
rest of the features contained in the hot plug then the code size becomes 
significant and we may want to have a config variable for that.


