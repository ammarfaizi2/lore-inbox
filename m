Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946721AbWKKAJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946721AbWKKAJZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 19:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946813AbWKKAJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 19:09:25 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:40125 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1946721AbWKKAJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 19:09:24 -0500
Date: Sat, 11 Nov 2006 09:08:51 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
Cc: clameter@sgi.com, hch@lst.de, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] add dev_to_node()
Message-Id: <20061111090851.73d4d3b6.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1163183306.15159.6.camel@localhost>
References: <20061030141501.GC7164@lst.de>
	<20061030.143357.130208425.davem@davemloft.net>
	<20061104225629.GA31437@lst.de>
	<20061108114038.59831f9d.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0611101015060.25338@schroedinger.engr.sgi.com>
	<1163183306.15159.6.camel@localhost>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2006 13:28:25 -0500
Lee Schermerhorn <Lee.Schermerhorn@hp.com> wrote:

> On Fri, 2006-11-10 at 10:16 -0800, Christoph Lameter wrote:
> > On Wed, 8 Nov 2006, KAMEZAWA Hiroyuki wrote:
> > 
> > > I wonder there are no code for creating NODE_DATA() for device-only-node.
> > 
> > On IA64 we remap nodes with no memory / cpus to the nearest node with 
> > memory. I think that is sufficient.
> 
> I don't think this happens anymore.  

In my understanding , from drivers/acpi/numa.c, 
a node is created by a pxm found in SRAT table at boot time.

the node-number for the pxm which was not found in SRAT at boot time is "-1".
please check how acpi_map_pxm_to_node() is used.

If pci's node-id is based on pxm, checking return vaule of pxm_to_node() 
will be good.

-Kame

