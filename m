Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031073AbWKPD2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031073AbWKPD2o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 22:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031075AbWKPD2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 22:28:43 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:8601 "EHLO omx1.sgi.com")
	by vger.kernel.org with ESMTP id S1031073AbWKPD2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 22:28:42 -0500
Date: Wed, 15 Nov 2006 21:28:35 -0600
From: Jack Steiner <steiner@sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: Christian Krafft <krafft@de.ibm.com>, linux-mm@kvack.org,
       Martin Bligh <mbligh@mbligh.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] enables booting a NUMA system where some nodes have no memory
Message-ID: <20061116032835.GA25299@sgi.com>
References: <20061115193049.3457b44c@localhost> <20061115193437.25cdc371@localhost> <Pine.LNX.4.64.0611151323330.22074@schroedinger.engr.sgi.com> <20061115215845.GB20526@sgi.com> <Pine.LNX.4.64.0611151432050.23201@schroedinger.engr.sgi.com> <20061116013534.GB1066@sgi.com> <Pine.LNX.4.64.0611151754480.24793@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611151754480.24793@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2006 at 05:57:27PM -0800, Christoph Lameter wrote:
> On Wed, 15 Nov 2006, Jack Steiner wrote:
> 
> > I doubt that there is a demand for systems with memoryless nodes. However, if the
> > DIMM(s) on a node fails, I think the system may perform better
> > with the cpus on the node enabled than it will if they have to be
> > disabled.
> 
> Right now we do not have the capability to remove memory from a node while 
> the system is running.

I know. I'm refering to a DIMM that fails power-on diags or one
that is explicitly disabled from the system controller.

Clearly a reboot is required in both cases, but the end result is
a node with cpus and no memory. As I said earlier, the PROM (for several 
reasons) automatically the cpus on nodes w/o memory.

