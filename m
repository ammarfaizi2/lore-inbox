Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263340AbVGORyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbVGORyY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 13:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263349AbVGORyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 13:54:24 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:18702 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S263340AbVGORyW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 13:54:22 -0400
Date: Fri, 15 Jul 2005 18:54:30 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Andi Kleen <ak@suse.de>, "Brown, Len" <len.brown@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, vojtech@suse.cz,
       christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <20050715102349.A15791@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.61L.0507151848440.15977@blysk.ds.pg.gda.pl>
References: <F7DC2337C7631D4386A2DF6E8FB22B300410F46A@hdsmsx401.amr.corp.intel.com.suse.lists.linux.kernel>
 <p73y8889f4v.fsf@bragg.suse.de> <20050715102349.A15791@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2005, Venkatesh Pallipadi wrote:

> I wouldn't say it is totally impossible. There are ways in which Linux can work
> without a reliable Local APIC timer. One option being - make one CPU that gets 
> the external timer interrupt multicast an IPI to all the other CPUs that
> wants to get periodic timer interrupt.

 That's like scratching your left ear with your right hand -- broadcasting 
that external timer interrupt in the first place is more straightforward.  
If you want to exclude CPUs from the list of receivers, just use the 
logical destination mode appropriately.

  Maciej
