Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162168AbWKPCJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162168AbWKPCJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162167AbWKPCJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:09:26 -0500
Received: from dvhart.com ([64.146.134.43]:28316 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1162166AbWKPCJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:09:25 -0500
Message-ID: <455BC854.9070708@mbligh.org>
Date: Wed, 15 Nov 2006 18:09:24 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
Cc: Jack Steiner <steiner@sgi.com>, Christian Krafft <krafft@de.ibm.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] enables booting a NUMA system where some nodes have
 no memory
References: <20061115193049.3457b44c@localhost> <20061115193437.25cdc371@localhost> <Pine.LNX.4.64.0611151323330.22074@schroedinger.engr.sgi.com> <20061115215845.GB20526@sgi.com> <Pine.LNX.4.64.0611151432050.23201@schroedinger.engr.sgi.com> <20061116013534.GB1066@sgi.com> <Pine.LNX.4.64.0611151754480.24793@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0611151754480.24793@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Wed, 15 Nov 2006, Jack Steiner wrote:
> 
>> I doubt that there is a demand for systems with memoryless nodes. However, if the
>> DIMM(s) on a node fails, I think the system may perform better
>> with the cpus on the node enabled than it will if they have to be
>> disabled.
> 
> Right now we do not have the capability to remove memory from a node while 
> the system is running.
> 
> If the DIMMs have failed and we boot up and the systems finds out that 
> there is no memory on that node then the cpus can be remapped to 
> the next memory node. That is better than having lots of useless 
> structures allocated.

A node without memory is a node without memory. Simply remapping the
cpus to another node and pretending the world is different does not
make much sense.

Is there some fundamental problem you see with dealing with the nodes
as is? Doesn't seem that hard to me. I'm not asking you to put the
effort in to fixing it, just if you see some fundamental reason why
it can't be fixed?

M.
