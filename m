Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161716AbWKOVZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161716AbWKOVZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 16:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161717AbWKOVZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 16:25:28 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:45532 "EHLO omx1.sgi.com")
	by vger.kernel.org with ESMTP id S1161716AbWKOVZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 16:25:27 -0500
Date: Wed, 15 Nov 2006 13:24:55 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Christian Krafft <krafft@de.ibm.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] enables booting a NUMA system where some nodes have
 no memory
In-Reply-To: <20061115193437.25cdc371@localhost>
Message-ID: <Pine.LNX.4.64.0611151323330.22074@schroedinger.engr.sgi.com>
References: <20061115193049.3457b44c@localhost> <20061115193437.25cdc371@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006, Christian Krafft wrote:

> When booting a NUMA system with nodes that have no memory (eg by limiting memory),
> bootmem_alloc_core tried to find pages in an uninitialized bootmem_map.

Why should we support nodes with no memory? If a node has no memory then 
its processors and other resources need to be attached to the nearest node 
with memory.

AFAICT The primary role of a node is to manage memory.
