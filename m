Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbVLFSCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbVLFSCV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbVLFSBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:01:53 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:1181 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964974AbVLFSBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:01:39 -0500
Date: Tue, 6 Dec 2005 10:01:28 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: akpm@osdl.org, Christoph Hellwig <hch@infradead.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH 1/2] Zone reclaim V2
In-Reply-To: <20051206175256.GO11190@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0512060957160.18975@schroedinger.engr.sgi.com>
References: <20051206172444.18786.30131.sendpatchset@schroedinger.engr.sgi.com>
 <20051206175256.GO11190@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Dec 2005, Andi Kleen wrote:

> > An arch can control zone_reclaim by setting zone_reclaim_mode during bootup
> > if it is discovered that the kernel is running on an NUMA configuration.
> 
> Looks much better. Thanks. But how about auto controlling the variable in generic
> code based on node_distance() (at least for the non node hotplug case)

Any suggestions on how to determine zone reclaim behavior based on node 
distances? AFAIK the main aspects in this are latency and bandwidth of 
remote accesses. These vary depending on the distance of the remote node 
under consideration.

> > +int zone_reclaim_mode;
> 
> I would mark it __read_mostly to avoid potential false sharing.

Ok.
