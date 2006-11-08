Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753843AbWKHCB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843AbWKHCB6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 21:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753849AbWKHCB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 21:01:58 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:42377 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1753843AbWKHCB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 21:01:58 -0500
Date: Tue, 7 Nov 2006 18:01:11 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, stable@kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Fix sys_move_pages when a NULL node list is passed.
In-Reply-To: <20061108105648.4a149cca.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0611071800250.7749@schroedinger.engr.sgi.com>
References: <20061103144243.4601ba76.sfr@canb.auug.org.au>
 <20061108105648.4a149cca.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2006, KAMEZAWA Hiroyuki wrote:

> >  	pm[nr_pages].node = MAX_NUMNODES;
> 
> I think node0 is always online...but this should be
> 
> pm[i].node = first_online_node; // /* any online node */

No it is a marker. The use of any node that is online could lead to a 
false determination of the endpoint of the list.

