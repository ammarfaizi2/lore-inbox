Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751835AbWITQsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbWITQsZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 12:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbWITQsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 12:48:25 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:50137 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751835AbWITQsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 12:48:24 -0400
Date: Wed, 20 Sep 2006 09:48:13 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <npiggin@suse.de>
cc: Rohit Seth <rohitseth@google.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org,
       pj@sgi.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch00/05]: Containers(V2)- Introduction
In-Reply-To: <20060920164404.GA22913@wotan.suse.de>
Message-ID: <Pine.LNX.4.64.0609200944420.30793@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
 <20060920164404.GA22913@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Nick Piggin wrote:

> > Right thats what cpusets do and it has been working fine for years. Maybe 
> > Paul can help you if you find anything missing in the existing means to 
> > control resources.
> 
> What I like about Rohit's patches is the page tracking stuff which 
> seems quite simple but capable.
> 
> I suspect cpusets don't quite provide enough features for non-exclusive 
> use of memory (eg. page tracking for directed reclaim).

Look at the VM statistics please. We have detailed page statistics per 
zone these days. If there is anything missing then this would best be put 
into general functionality. When I looked at it, I saw page statistics 
that were replicating things that we already track per zone. All these 
would become available if a container is realized via a node and we would 
be using proven VM code.


