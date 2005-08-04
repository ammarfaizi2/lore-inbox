Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262563AbVHDOdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbVHDOdj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 10:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbVHDObd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 10:31:33 -0400
Received: from cantor2.suse.de ([195.135.220.15]:50915 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261732AbVHDO3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 10:29:44 -0400
Date: Thu, 4 Aug 2005 16:29:42 +0200
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] String conversions for memory policy
Message-ID: <20050804142942.GY8266@wotan.suse.de>
References: <20050729230026.1aa27e14.pj@sgi.com> <Pine.LNX.4.62.0507301042420.26355@graphe.net> <20050730181418.65caed1f.pj@sgi.com> <Pine.LNX.4.62.0507301814540.31359@graphe.net> <20050730190126.6bec9186.pj@sgi.com> <Pine.LNX.4.62.0507301904420.31882@graphe.net> <20050730191228.15b71533.pj@sgi.com> <Pine.LNX.4.62.0508011147030.5541@graphe.net> <20050803084849.GB10895@wotan.suse.de> <Pine.LNX.4.62.0508040704590.3319@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0508040704590.3319@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 07:11:36AM -0700, Christoph Lameter wrote:
> On Wed, 3 Aug 2005, Andi Kleen wrote:
> 
> > I really hate this whole /proc/<pid>/numa_policy thing. /proc/<pid>/maps
> > was imho always a desaster (hard to parse, slow etc.). Also external
> > access of NUMA policies has interesting locking issues. I intentionally
> > didn't add something like that when I designed the original
> > NUMA API. Please don't add it.
> 
> You designed a NUMA API to control a process memory access patterns 
> without the ability to view or modify the policies in use?

Processes internally can get the information if they want.
Externally I didn't expose it intentionally to avoid locking problems

> The locking issues for the policy information in the task_struct could be 
> solved by having a thread execute a function that either sets or gets the 
> memory policy. The vma policies already have a locking mechanism.

But why? It all only adds complexity. Keep it simple please.

>  
> This piece here only does conversion to a string representation so it 
> should not be affected by locking issues. Processes need to do proper 
> locking when using the conversion functions.

It's useless.

-Andi
