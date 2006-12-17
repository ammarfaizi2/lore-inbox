Return-Path: <linux-kernel-owner+w=401wt.eu-S1751583AbWLQBDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbWLQBDs (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 20:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbWLQBDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 20:03:48 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:57494 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582AbWLQBDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 20:03:47 -0500
Date: Sun, 17 Dec 2006 10:02:58 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, clameter@engr.sgi.com,
       apw@shadowen.org, heiko.carstens@de.ibm.com, bob.picco@hp.com
Subject: Re: [PATCH][2.6.20-rc1-mm1] sparsemem vmem_map optimzed pfn_valid()
 [0/2]
Message-Id: <20061217100258.faf504a9.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0612161038080.5044@schroedinger.engr.sgi.com>
References: <20061216173136.fbc91fa6.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0612161038080.5044@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2006 10:38:53 -0800 (PST)
Christoph Lameter <clameter@sgi.com> wrote:

> On Sat, 16 Dec 2006, KAMEZAWA Hiroyuki wrote:
> 
> > By this, we'll not access mem_section[] in usual ops.
> 
> Why do we need mem_section? We have a page table that fulfills the same 
> role.
> 
Basically, we don't need it.
But I use mem_section[] in bootstrap and I want to keep patches small in this
time. 
I think it's not too late that we'll consider removing it after implementing
memory hot unplug.(and confirm we never use it.)

-Kame 

