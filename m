Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWBFSZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWBFSZV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 13:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWBFSZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 13:25:21 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:57825 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932276AbWBFSZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 13:25:21 -0500
Date: Mon, 6 Feb 2006 10:25:05 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: discuss@x86-64.org, bharata@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes
 2.6.16-rc1[2] on 2 node X86_64
In-Reply-To: <200602061912.31508.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0602061023580.16829@schroedinger.engr.sgi.com>
References: <20060205163618.GB21972@in.ibm.com> <200602051803.59437.ak@suse.de>
 <Pine.LNX.4.62.0602060807530.15863@schroedinger.engr.sgi.com>
 <200602061912.31508.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006, Andi Kleen wrote:

> > Tried the following code on rc1 and rc2 and it worked fine on ia64:
> 
> Perhaps it depends on if the node has enough memory free or not?
> I assume if the zonelist has some issue but the first entry is ok
> it will only cause problems when the allocation has to go off node
> (it shouldn't actually go off node with that policy of course,

If node 0 is exhausted then you have an OOM situation.

> but with a full free local node that code path is never triggered)

Wamt me to test the OOM path for mbind?

