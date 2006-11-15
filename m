Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031016AbWKOWxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031016AbWKOWxO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 17:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031017AbWKOWxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 17:53:14 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:35302 "EHLO omx1.sgi.com")
	by vger.kernel.org with ESMTP id S1031016AbWKOWxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 17:53:13 -0500
Date: Wed, 15 Nov 2006 14:52:43 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Martin Bligh <mbligh@mbligh.org>
cc: Jack Steiner <steiner@sgi.com>, Christian Krafft <krafft@de.ibm.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] enables booting a NUMA system where some nodes have
 no memory
In-Reply-To: <455B9825.3030403@mbligh.org>
Message-ID: <Pine.LNX.4.64.0611151451450.23477@schroedinger.engr.sgi.com>
References: <20061115193049.3457b44c@localhost> <20061115193437.25cdc371@localhost>
 <Pine.LNX.4.64.0611151323330.22074@schroedinger.engr.sgi.com>
 <20061115215845.GB20526@sgi.com> <Pine.LNX.4.64.0611151432050.23201@schroedinger.engr.sgi.com>
 <455B9825.3030403@mbligh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006, Martin Bligh wrote:

> All we need is an appropriate zonelist for each node, pointing to
> the memory it should be accessing.

But there is no memory on the node. Does the zonelist contain the zones of 
the node without memory or not? We simply fall back each allocation to the 
next node as if the node was overflowing?

