Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262813AbUKXRwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbUKXRwu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 12:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbUKXRua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 12:50:30 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:44228 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262770AbUKXRtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 12:49:20 -0500
Date: Wed, 24 Nov 2004 17:48:58 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Nick Warne <nick@linicks.net>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.28 -> ch..ch...changes....
In-Reply-To: <20041124070821.GA8718@logos.cnet>
Message-ID: <Pine.LNX.4.44.0411241744210.5172-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2004, Marcelo Tosatti wrote:
> On Tue, Nov 23, 2004 at 09:36:36PM +0000, Nick Warne wrote:
> > 
> > I updated three boxes today to 2.4.28 (from .27), one at work, and two here at 
> > home (Redhat 7.1+, Slackware 10)
> > 
> > I am intrigued terribly by the small footprint of memory usage now.  I have 
> > gone through the changes file, but can really see nothing (to me, a n00b) 
> > that would alter that?
> > 
> > Can anyone enlighten me?
> 
> What do you mean by "memory usage"? SLAB (/proc/slabinfo) buffers
> or pagecache ?
> 
> Whats your workload and what drivers are you using ?
> 
> Nothing that I am aware of explains this.

_If_ it's a reduction in /proc/slabinfo's dentry_cache, and
_if_ these boxes do a lot of removing files from tmpfs,
then it would be the "tmpfs: stop negative dentries".

Hugh

