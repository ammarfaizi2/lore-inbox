Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946371AbWKAB6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946371AbWKAB6i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 20:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946372AbWKAB6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 20:58:38 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:155 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1946371AbWKAB6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 20:58:38 -0500
Date: Tue, 31 Oct 2006 17:58:31 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: David Miller <davem@davemloft.net>
cc: hch@lst.de, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       linux-mm@kvack.org
Subject: Re: [PATCH 2/3] add dev_to_node()
In-Reply-To: <20061031.165314.39158827.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0610311757040.8656@schroedinger.engr.sgi.com>
References: <20061030141501.GC7164@lst.de> <20061030.143357.130208425.davem@davemloft.net>
 <Pine.LNX.4.64.0610311610150.7609@schroedinger.engr.sgi.com>
 <20061031.165314.39158827.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2006, David Miller wrote:

> Yes, that's possible, because the idea is that the arch specific
> bus layer code would initialize the node value.  Therefore, there
> would be no need for things like pcibus_to_node() any longer.

Then lets rename pcibus_to_node to dev_to_node() throughout the kernel. 
Provide a -1 default. Then other device layers that are not based on pci 
will also be able to exploit NUMA locality.
