Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263359AbVGOSFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263359AbVGOSFZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 14:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263353AbVGOSFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 14:05:13 -0400
Received: from fmr23.intel.com ([143.183.121.15]:59295 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S263355AbVGOSCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 14:02:55 -0400
Date: Fri, 15 Jul 2005 11:01:57 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Andi Kleen <ak@suse.de>, "Brown, Len" <len.brown@intel.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       vojtech@suse.cz, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050715110157.A16008@unix-os.sc.intel.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B300410F46A@hdsmsx401.amr.corp.intel.com.suse.lists.linux.kernel> <p73y8889f4v.fsf@bragg.suse.de> <20050715102349.A15791@unix-os.sc.intel.com> <Pine.LNX.4.61L.0507151848440.15977@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.61L.0507151848440.15977@blysk.ds.pg.gda.pl>; from macro@linux-mips.org on Fri, Jul 15, 2005 at 06:54:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 06:54:30PM +0100, Maciej W. Rozycki wrote:
> On Fri, 15 Jul 2005, Venkatesh Pallipadi wrote:
> 
> > I wouldn't say it is totally impossible. There are ways in which Linux can work
> > without a reliable Local APIC timer. One option being - make one CPU that gets 
> > the external timer interrupt multicast an IPI to all the other CPUs that
> > wants to get periodic timer interrupt.
> 
>  That's like scratching your left ear with your right hand -- broadcasting 
> that external timer interrupt in the first place is more straightforward.  
> If you want to exclude CPUs from the list of receivers, just use the 
> logical destination mode appropriately.
> 

Well.. I tried a patch to do the broadcast thing couple of months ago and 
failed to convince everyone :(.

Further, it doesn't work well if you want to exclude some CPUs from the list of recievers. Logical destination is simple only for less than 8 CPUs. Beyond that
with clustered or physical configuration it is difficult.

Thanks,
Venki

