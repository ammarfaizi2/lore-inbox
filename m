Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbUKIUet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbUKIUet (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 15:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbUKIUer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 15:34:47 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:30336 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261666AbUKIUec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 15:34:32 -0500
Date: Wed, 10 Nov 2004 07:34:17 +1100 (EST)
From: Mark Goodwin <markgw@sgi.com>
X-X-Sender: markgw@woolami.melbourne.sgi.com
To: Matthew Dobson <colpatch@us.ibm.com>
cc: Erich Focht <efocht@hpce.nec.com>, Jack Steiner <steiner@sgi.com>,
       Takayoshi Kochi <t-kochi@bq.jp.nec.com>, linux-ia64@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Externalize SLIT table
In-Reply-To: <1100029381.3980.12.camel@arrakis>
Message-ID: <Pine.LNX.4.61.0411100722070.14545@woolami.melbourne.sgi.com>
References: <20041103205655.GA5084@sgi.com>  <20041104.105908.18574694.t-kochi@bq.jp.nec.com>
  <20041104141337.GA18445@sgi.com>  <200411041631.42627.efocht@hpce.nec.com>
 <1100029381.3980.12.camel@arrakis>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Nov 2004, Matthew Dobson wrote:
> ...
> I don't think we should export the *exact same* node distance information
> through the CPUs, though.

We should still export cpu distances though because the distance between
cpus on the same node may not be equal. e.g. consider a node with multiple
cpu sockets, each socket with a hyperthreaded (or dual core) cpu.

Once again however, it depends on the definition of distance. For nodes,
we've established it's the ACPI SLIT (relative distance to memory). For
cpus, should it be distance to memory? Distance to cache? Registers? Or
what?

-- Mark
