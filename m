Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVAGXXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVAGXXg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 18:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVAGXVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 18:21:09 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:15806 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261700AbVAGXRp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 18:17:45 -0500
Subject: Re: [RFC] 2.4 and stack reduction patches
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1105137646.10979.155.camel@lade.trondhjem.org>
References: <1105112886.4000.87.camel@dyn318077bld.beaverton.ibm.com>
	 <20050107141224.GF29176@logos.cnet>
	 <1105134173.4000.105.camel@dyn318077bld.beaverton.ibm.com>
	 <1105137646.10979.155.camel@lade.trondhjem.org>
Content-Type: text/plain
Organization: 
Message-Id: <1105138242.4000.117.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Jan 2005 14:50:42 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-07 at 14:40, Trond Myklebust wrote:
> fr den 07.01.2005 Klokka 13:42 (-0800) skreiv Badari Pulavarty:
> 
> > Here are the changes and savings.
> > 
> > do_execve                    320
> > number                       100
> > nfs_lookup                   184
> > nfs_cached_lookup             88
> > __revalidate_inode           112
> > rpc_call_sync                144
> > xprt_sendmsg                 120
> 
> There is no nfs_cached_lookup() in the mainline 2.4 tree. That is part
> of the READDIRPLUS code, and was therefore never merged.

Like I mentioned earlier, this patch was done for a distro release
not mainline. I need to look at mainline code.

> 
> You're better off using rpc_new_task() in rpc_call_sync(): no kfree()
> required, and no rpc_init_task() required.

Sure. Will do.

Thanks,
Badari

