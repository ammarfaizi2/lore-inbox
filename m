Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263361AbVGOSBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263361AbVGOSBl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 14:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263351AbVGOR7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 13:59:18 -0400
Received: from cantor2.suse.de ([195.135.220.15]:47273 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S263355AbVGOR6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 13:58:20 -0400
Date: Fri, 15 Jul 2005 19:58:19 +0200
From: Andi Kleen <ak@suse.de>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Andi Kleen <ak@suse.de>, "Brown, Len" <len.brown@intel.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       vojtech@suse.cz, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050715175819.GF15783@wotan.suse.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B300410F46A@hdsmsx401.amr.corp.intel.com.suse.lists.linux.kernel> <p73y8889f4v.fsf@bragg.suse.de> <20050715102349.A15791@unix-os.sc.intel.com> <Pine.LNX.4.61L.0507151848440.15977@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0507151848440.15977@blysk.ds.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  That's like scratching your left ear with your right hand -- broadcasting 
> that external timer interrupt in the first place is more straightforward.  
> If you want to exclude CPUs from the list of receivers, just use the 
> logical destination mode appropriately.

The problem with that is that it would need regular synchronizations
of all CPUs to coordinate this.   Not good for scalability and I 
believe the fundamentally wrong way to do this.

-Andi
