Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbVGaCFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVGaCFp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 22:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVGaCFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 22:05:45 -0400
Received: from graphe.net ([209.204.138.32]:10924 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261523AbVGaCFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 22:05:43 -0400
Date: Sat, 30 Jul 2005 19:05:41 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Paul Jackson <pj@sgi.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] String conversions for memory policy
In-Reply-To: <20050730190126.6bec9186.pj@sgi.com>
Message-ID: <Pine.LNX.4.62.0507301904420.31882@graphe.net>
References: <Pine.LNX.4.62.0507291137240.3864@graphe.net>
 <20050729152049.4b172d78.pj@sgi.com> <Pine.LNX.4.62.0507291746000.8663@graphe.net>
 <20050729230026.1aa27e14.pj@sgi.com> <Pine.LNX.4.62.0507301042420.26355@graphe.net>
 <20050730181418.65caed1f.pj@sgi.com> <Pine.LNX.4.62.0507301814540.31359@graphe.net>
 <20050730190126.6bec9186.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jul 2005, Paul Jackson wrote:

> Christoph wrote:
> > The problem is how to convert them back for display. Match the zones in 
> > groups of three to the zones in a node and then print out the node?
> 
> What does get_mempolicy(2) do?  I doubt it assumes groups of three.
> See further the case for MPOL_BIND, in mm/mempolicy.c:get_zonemask().

It sets all the node bits by looping over all zones using 
zone->zone_pgdat->node_id.


