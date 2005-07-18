Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVGRKrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVGRKrJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 06:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVGRKrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 06:47:09 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:40712 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261602AbVGRKrH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 06:47:07 -0400
Date: Mon, 18 Jul 2005 11:47:07 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andi Kleen <ak@suse.de>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       "Brown, Len" <len.brown@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, vojtech@suse.cz,
       christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <20050715175819.GF15783@wotan.suse.de>
Message-ID: <Pine.LNX.4.61L.0507181140200.527@blysk.ds.pg.gda.pl>
References: <F7DC2337C7631D4386A2DF6E8FB22B300410F46A@hdsmsx401.amr.corp.intel.com.suse.lists.linux.kernel>
 <p73y8889f4v.fsf@bragg.suse.de> <20050715102349.A15791@unix-os.sc.intel.com>
 <Pine.LNX.4.61L.0507151848440.15977@blysk.ds.pg.gda.pl>
 <20050715175819.GF15783@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2005, Andi Kleen wrote:

> >  That's like scratching your left ear with your right hand -- broadcasting 
> > that external timer interrupt in the first place is more straightforward.  
> > If you want to exclude CPUs from the list of receivers, just use the 
> > logical destination mode appropriately.
> 
> The problem with that is that it would need regular synchronizations
> of all CPUs to coordinate this.   Not good for scalability and I 
> believe the fundamentally wrong way to do this.

 What to you mean by "regular synchronizations of all CPUs?"  And how is a 
broadcasted external timer interrupt different from a unicasted one 
redistributed further via an all-but-self IPI, except from removing an 
unnecessary burden from the CPU targeted by the unicast interrupt?

  Maciej
