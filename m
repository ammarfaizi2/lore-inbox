Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161824AbWKOWFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161824AbWKOWFs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 17:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161827AbWKOWFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 17:05:48 -0500
Received: from dvhart.com ([64.146.134.43]:34457 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1161824AbWKOWFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 17:05:48 -0500
Message-ID: <455B8F3A.6030503@mbligh.org>
Date: Wed, 15 Nov 2006 14:05:46 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
Cc: Christian Krafft <krafft@de.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] enables booting a NUMA system where some nodes have
 no memory
References: <20061115193049.3457b44c@localhost> <20061115193437.25cdc371@localhost> <Pine.LNX.4.64.0611151323330.22074@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0611151323330.22074@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Wed, 15 Nov 2006, Christian Krafft wrote:
> 
>> When booting a NUMA system with nodes that have no memory (eg by limiting memory),
>> bootmem_alloc_core tried to find pages in an uninitialized bootmem_map.
> 
> Why should we support nodes with no memory? If a node has no memory then 
> its processors and other resources need to be attached to the nearest node 
> with memory.
> 
> AFAICT The primary role of a node is to manage memory.

A node is an arbitrary container object containing one or more of:

CPUs
Memory
IO bus

It does not have to contain memory.

M.
