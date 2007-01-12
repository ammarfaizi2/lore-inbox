Return-Path: <linux-kernel-owner+w=401wt.eu-S1030497AbXALDFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030497AbXALDFF (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 22:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbXALDFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 22:05:05 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:38835 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030497AbXALDFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 22:05:03 -0500
Date: Thu, 11 Jan 2007 19:04:50 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: David Chinner <dgc@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [REGRESSION] 2.6.19/2.6.20-rc3 buffered write slowdown
In-Reply-To: <45A6D118.5030508@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0701111903110.31979@schroedinger.engr.sgi.com>
References: <20070110223731.GC44411608@melbourne.sgi.com>
 <Pine.LNX.4.64.0701101503310.22578@schroedinger.engr.sgi.com>
 <20070110230855.GF44411608@melbourne.sgi.com> <45A57333.6060904@yahoo.com.au>
 <20070111003158.GT33919298@melbourne.sgi.com> <45A58DFA.8050304@yahoo.com.au>
 <20070111012404.GW33919298@melbourne.sgi.com> <45A602F0.1090405@yahoo.com.au>
 <Pine.LNX.4.64.0701110950380.28802@schroedinger.engr.sgi.com>
 <45A6D118.5030508@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2007, Nick Piggin wrote:

> Ah yes... Can't you force it on if you have a NUMA complied kernel?

But it wont do anything since it only comes into action if you have an off 
node allocation. If you run a NUMA kernel on an SMP system then you only 
have one node. There is no way that an off node allocation can occur.

> > zone reclaim was already in 2.6.16.
> 
> Well it was a long shot, but that is something that has had a few
> changes recently and is something that could interact badly with
> the global pdflush.

zone reclaim is not touching dirty pages in its default configuration. It 
would only remove up clean pagecache pages.


