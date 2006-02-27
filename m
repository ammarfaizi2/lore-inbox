Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbWB0Wki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWB0Wki (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWB0Wk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:40:26 -0500
Received: from ns2.suse.de ([195.135.220.15]:25989 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932470AbWB0Wjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:39:53 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [PATCH 01/02] cpuset memory spread slab cache filesys
Date: Mon, 27 Feb 2006 23:39:41 +0100
User-Agent: KMail/1.9.1
Cc: Paul Jackson <pj@sgi.com>, dgc@sgi.com, steiner@sgi.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, clameter@sgi.com
References: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com> <200602272202.34346.ak@suse.de> <Pine.LNX.4.64.0602271414290.12093@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0602271414290.12093@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602272339.42574.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 February 2006 23:14, Christoph Lameter wrote:
> On Mon, 27 Feb 2006, Andi Kleen wrote:
> 
> > On Monday 27 February 2006 21:56, Christoph Lameter wrote:
> > > We could make the memory policy only apply if the SLAB_MEM_SPREAD option 
> > Which memory policy? The one of the process?
> 
> Yes.

I don't quite get your logic here. For me it would be logical to apply
the memory policy from the process for anything _but_ slab caches
that have SLAB_MEM_SPREAD set. For those interleaving should be always used.

Why are you proposing to do it the other way round?

-Andi

