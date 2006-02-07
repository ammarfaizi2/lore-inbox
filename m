Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbWBGRHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWBGRHF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWBGRHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:07:05 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:19590 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750961AbWBGRHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:07:03 -0500
Date: Tue, 7 Feb 2006 09:06:47 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>, akpm@osdl.org,
       dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
In-Reply-To: <20060207123001.GA634@elte.hu>
Message-ID: <Pine.LNX.4.62.0602070904460.24623@schroedinger.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
 <200602071031.40346.ak@suse.de> <20060207115307.GA25110@elte.hu>
 <200602071314.34879.ak@suse.de> <20060207123001.GA634@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2006, Ingo Molnar wrote:

> * Andi Kleen <ak@suse.de> wrote:
> 
> > I still don't really think it will make much difference if the file 
> > cache is local or global. Compare to disk IO it is still infinitely 
> > faster, so a relatively small slowdown from going off node is not that 
> > big an issue.
> 
> well, maybe the SGI folks can give us some numbers?

The latency may grow (average) by a factor of 4 (same thoughput though on 
our boxes). On some architectures it is significantly more and also the 
bandwidth is reduced.

This is a significant factor. Applications that do not manage locality 
correctly loose at least 30-40% performance.

