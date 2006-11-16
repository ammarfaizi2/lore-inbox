Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162156AbWKPB5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162156AbWKPB5h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 20:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162158AbWKPB5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 20:57:37 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:50830 "EHLO omx1.sgi.com")
	by vger.kernel.org with ESMTP id S1162156AbWKPB5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 20:57:37 -0500
Date: Wed, 15 Nov 2006 17:57:27 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Jack Steiner <steiner@sgi.com>
cc: Christian Krafft <krafft@de.ibm.com>, linux-mm@kvack.org,
       Martin Bligh <mbligh@mbligh.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] enables booting a NUMA system where some nodes have
 no memory
In-Reply-To: <20061116013534.GB1066@sgi.com>
Message-ID: <Pine.LNX.4.64.0611151754480.24793@schroedinger.engr.sgi.com>
References: <20061115193049.3457b44c@localhost> <20061115193437.25cdc371@localhost>
 <Pine.LNX.4.64.0611151323330.22074@schroedinger.engr.sgi.com>
 <20061115215845.GB20526@sgi.com> <Pine.LNX.4.64.0611151432050.23201@schroedinger.engr.sgi.com>
 <20061116013534.GB1066@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006, Jack Steiner wrote:

> I doubt that there is a demand for systems with memoryless nodes. However, if the
> DIMM(s) on a node fails, I think the system may perform better
> with the cpus on the node enabled than it will if they have to be
> disabled.

Right now we do not have the capability to remove memory from a node while 
the system is running.

If the DIMMs have failed and we boot up and the systems finds out that 
there is no memory on that node then the cpus can be remapped to 
the next memory node. That is better than having lots of useless 
structures allocated.
