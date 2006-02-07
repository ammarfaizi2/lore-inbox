Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWBGRaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWBGRaJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWBGRaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:30:09 -0500
Received: from ns.suse.de ([195.135.220.2]:18611 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751086AbWBGRaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:30:06 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Date: Tue, 7 Feb 2006 18:26:17 +0100
User-Agent: KMail/1.8.2
Cc: Ingo Molnar <mingo@elte.hu>, Paul Jackson <pj@sgi.com>, akpm@osdl.org,
       dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <20060207123001.GA634@elte.hu> <Pine.LNX.4.62.0602070904460.24623@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602070904460.24623@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071826.18612.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 18:06, Christoph Lameter wrote:
> On Tue, 7 Feb 2006, Ingo Molnar wrote:
> 
> > * Andi Kleen <ak@suse.de> wrote:
> > 
> > > I still don't really think it will make much difference if the file 
> > > cache is local or global. Compare to disk IO it is still infinitely 
> > > faster, so a relatively small slowdown from going off node is not that 
> > > big an issue.
> > 
> > well, maybe the SGI folks can give us some numbers?
> 
> The latency may grow (average) by a factor of 4 (same thoughput though on 
> our boxes). On some architectures it is significantly more and also the 
> bandwidth is reduced.
> 
> This is a significant factor. Applications that do not manage locality 
> correctly loose at least 30-40% performance.

This number is for local mapped memory I assume.

But do you have any numbers for file caches or dentry/inode caches? 
My guess is that if an  application would lose that much in read/write 
or readdir/stat it would call them too often :) But it's unlikely
i guess.

-Andi
