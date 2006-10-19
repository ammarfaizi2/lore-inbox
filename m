Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946526AbWJSVai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946526AbWJSVai (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 17:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946522AbWJSVai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 17:30:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:31679 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1946526AbWJSVah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 17:30:37 -0400
Date: Thu, 19 Oct 2006 14:30:30 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
cc: Paul Mackerras <paulus@samba.org>, akpm@osdl.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
In-Reply-To: <1161290304.8946.54.camel@farscape>
Message-ID: <Pine.LNX.4.64.0610191429010.10316@schroedinger.engr.sgi.com>
References: <1160764895.11239.14.camel@farscape> 
 <Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com> 
 <1160769226.11239.22.camel@farscape> <1160773040.11239.28.camel@farscape> 
 <Pine.LNX.4.64.0610131515200.28279@schroedinger.engr.sgi.com> 
 <1161026409.31903.15.camel@farscape>  <Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
  <1161031821.31903.28.camel@farscape>  <Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
  <17717.50596.248553.816155@cargo.ozlabs.ibm.com> 
 <Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com> 
 <17718.39522.456361.987639@cargo.ozlabs.ibm.com> 
 <Pine.LNX.4.64.0610181448250.30710@schroedinger.engr.sgi.com> 
 <17719.1849.245776.4501@cargo.ozlabs.ibm.com> 
 <Pine.LNX.4.64.0610190906490.7852@schroedinger.engr.sgi.com>
 <1161290304.8946.54.camel@farscape>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006, Will Schmidt wrote:

> Is there a hook where we can see what/where the memory is going?  Does
> it seem reasonable for all of the memory that is in node 0 to be
> consumed? 
> Mine appears to have... 
> Node 0 MemTotal:       229376 kB
> Node 0 MemFree:             0 kB
> Node 0 MemUsed:        229376 kB

The memory is likely consumed before the slab allocator bootstrap code is 
reached.

> And one of Paul's earlier notes mentioned about a gig of ram on node0;

Yeah. I cannot make sense out of all of this. What is so special about 
node 0?


