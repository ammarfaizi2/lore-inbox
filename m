Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWDZSsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWDZSsk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 14:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWDZSsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 14:48:40 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:12748 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964816AbWDZSsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 14:48:39 -0400
Date: Wed, 26 Apr 2006 11:48:33 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: axboe@suse.de, linux-kernel@vger.kernel.org, npiggin@suse.de,
       linux-mm@kvack.org
Subject: Re: Lockless page cache test results
In-Reply-To: <20060426114737.239806a2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604261146040.20295@schroedinger.engr.sgi.com>
References: <20060426135310.GB5083@suse.de> <20060426095511.0cc7a3f9.akpm@osdl.org>
 <20060426174235.GC5002@suse.de> <20060426111054.2b4f1736.akpm@osdl.org>
 <Pine.LNX.4.64.0604261130450.19587@schroedinger.engr.sgi.com>
 <20060426114737.239806a2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2006, Andrew Morton wrote:

> > A real application scenario may be an application that has lots of threads 
> > that are streaming data through multiple different disk channels (that 
> > are able to transfer data simultanouesly. e.g. connected to different 
> > nodes in a NUMA system) into the same address space.
> > 
> > Something like the above is fairly typical for multimedia filters 
> > processing large amounts of data.
> 
> >From the same file?

Reading sections of the same file on multiple processors. This is done in 
order to obtain higher read performance than possible with single threaded
reading.

