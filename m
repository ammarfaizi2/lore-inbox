Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVETTED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVETTED (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 15:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVETTED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 15:04:03 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:29945 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261162AbVETTEA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 15:04:00 -0400
Message-ID: <428E3497.3080406@us.ibm.com>
Date: Fri, 20 May 2005 12:03:51 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
CC: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NUMA aware slab allocator V3
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com>  <Pine.LNX.4.62.0505161046430.1653@schroedinger.engr.sgi.com>  <714210000.1116266915@flay> <200505161410.43382.jbarnes@virtuousgeek.org>  <740100000.1116278461@flay>  <Pine.LNX.4.62.0505161713130.21512@graphe.net> <1116289613.26955.14.camel@localhost> <428A800D.8050902@us.ibm.com> <Pine.LNX.4.62.0505171648370.17681@graphe.net> <428B7B16.10204@us.ibm.com> <Pine.LNX.4.62.0505181046320.20978@schroedinger.engr.sgi.com> <428BB05B.6090704@us.ibm.com> <Pine.LNX.4.62.0505181439080.10598@graphe.net> <Pine.LNX.4.62.0505182105310.17811@graphe.net>
In-Reply-To: <Pine.LNX.4.62.0505182105310.17811@graphe.net>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph, I'm getting the following errors building rc4-mm2 w/ GCC 2.95.4:

mm/slab.c:281: field `entry' has incomplete typemm/slab.c: In function
'cache_alloc_refill':
mm/slab.c:2497: warning: control reaches end of non-void function
mm/slab.c: In function `kmem_cache_alloc':
mm/slab.c:2567: warning: `objp' might be used uninitialized in this function
mm/slab.c: In function `kmem_cache_alloc_node':
mm/slab.c:2567: warning: `objp' might be used uninitialized in this function
mm/slab.c: In function `__kmalloc':
mm/slab.c:2567: warning: `objp' might be used uninitialized in this function
make[1]: *** [mm/slab.o] Error 1
make[1]: *** Waiting for unfinished jobs....

-Matt
