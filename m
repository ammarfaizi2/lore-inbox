Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946205AbWJSQdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946205AbWJSQdK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946207AbWJSQdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:33:09 -0400
Received: from ozlabs.org ([203.10.76.45]:7139 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1946205AbWJSQdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:33:08 -0400
Date: Fri, 20 Oct 2006 02:30:44 +1000
From: Anton Blanchard <anton@samba.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Paul Mackerras <paulus@samba.org>, akpm@osdl.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
Message-ID: <20061019163044.GB5819@krispykreme>
References: <1161026409.31903.15.camel@farscape> <Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com> <1161031821.31903.28.camel@farscape> <Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com> <17717.50596.248553.816155@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com> <17718.39522.456361.987639@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0610181448250.30710@schroedinger.engr.sgi.com> <17719.1849.245776.4501@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0610190906490.7852@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610190906490.7852@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> Would you please make memory available on the node that you bootstrap 
> the slab allocator on? numa_node_id() must point to a node that has memory 
> available.

So we've gone from something that worked around sub optimal memory
layouts to something that panics. Sounds like a step backwards to me.

Anton
