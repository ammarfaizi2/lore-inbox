Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751867AbWB1BEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbWB1BEO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 20:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbWB1BEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 20:04:14 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:25768 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751867AbWB1BEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 20:04:13 -0500
Date: Mon, 27 Feb 2006 17:03:48 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Andi Kleen <ak@muc.de>, largret@gmail.com, 76306.1226@compuserve.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: OOM-killer too aggressive?
In-Reply-To: <20060227165921.242f6810.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0602271701160.13176@schroedinger.engr.sgi.com>
References: <200602260938_MC3-1-B94B-EE2B@compuserve.com>
 <20060226102152.69728696.akpm@osdl.org> <1140988015.5178.15.camel@shogun.daga.dyndns.org>
 <20060226133140.4cf05ea5.akpm@osdl.org> <20060226235142.GB91959@muc.de>
 <Pine.LNX.4.64.0602271429270.12204@schroedinger.engr.sgi.com>
 <20060228004115.GA37362@muc.de> <20060227165921.242f6810.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2006, Andrew Morton wrote:

> > On Mon, Feb 27, 2006 at 02:30:02PM -0800, Christoph Lameter wrote:
> > > Isnt this also a constrained allocation? We could expand the check to also 
> > > catch these types of restrictions and fail.
> > 
> > No, it uses the full fallback zone list of the target node, not a custom
> > one. Would be hard to detect without a flag.

Right but it specifies in its flags that not all system memory can satisfy 
this particular memory request. That fact may be detected by the 
out_of_memory() function. We could do something special there instead of 
OOMing.



