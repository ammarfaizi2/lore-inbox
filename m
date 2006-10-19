Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946460AbWJSUie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946460AbWJSUie (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 16:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946475AbWJSUie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 16:38:34 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:41856 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1946460AbWJSUic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 16:38:32 -0400
Subject: Re: kernel BUG in __cache_alloc_node at
	linux-2.6.git/mm/slab.c:3177!
From: Will Schmidt <will_schmidt@vnet.ibm.com>
Reply-To: will_schmidt@vnet.ibm.com
To: Christoph Lameter <clameter@sgi.com>
Cc: Paul Mackerras <paulus@samba.org>, akpm@osdl.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0610190906490.7852@schroedinger.engr.sgi.com>
References: <1160764895.11239.14.camel@farscape>
	 <Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com>
	 <1160769226.11239.22.camel@farscape> <1160773040.11239.28.camel@farscape>
	 <Pine.LNX.4.64.0610131515200.28279@schroedinger.engr.sgi.com>
	 <1161026409.31903.15.camel@farscape>
	 <Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
	 <1161031821.31903.28.camel@farscape>
	 <Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
	 <17717.50596.248553.816155@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com>
	 <17718.39522.456361.987639@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0610181448250.30710@schroedinger.engr.sgi.com>
	 <17719.1849.245776.4501@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0610190906490.7852@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: IBM
Date: Thu, 19 Oct 2006 15:38:24 -0500
Message-Id: <1161290304.8946.54.camel@farscape>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-19-10 at 09:16 -0700, Christoph Lameter wrote:
> On Thu, 19 Oct 2006, Paul Mackerras wrote:
> 
> > Get cache descritor
> 
> Attempt to allocate the first descriptor for the first cache.
> 
> > __cache_alloc
> 
> Attempt to allocate from the caches of node 0 (which are empty on 
> bootstrap). We try to replenish the caches of node 0 which should have 
> succeeded. I guess that this failed due to no pages available on 
> node 0. This should not happen!

Is there a hook where we can see what/where the memory is going?  Does
it seem reasonable for all of the memory that is in node 0 to be
consumed? 
Mine appears to have... 
Node 0 MemTotal:       229376 kB
Node 0 MemFree:             0 kB
Node 0 MemUsed:        229376 kB

And one of Paul's earlier notes mentioned about a gig of ram on node0;

-Will



