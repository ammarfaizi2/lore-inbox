Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267504AbUIGB0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267504AbUIGB0k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 21:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267494AbUIGB0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 21:26:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57729 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267495AbUIGB0Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 21:26:25 -0400
Date: Mon, 6 Sep 2004 21:03:04 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, raybry@sgi.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com,
       piggin@cyberone.com.au, mbligh@aracnet.com
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
Message-ID: <20040907000304.GA8083@logos.cnet>
References: <413CB661.6030303@sgi.com> <cone.1094512172.450816.6110.502@pc.kolivas.org> <20040906162740.54a5d6c9.akpm@osdl.org> <cone.1094513660.210107.6110.502@pc.kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cone.1094513660.210107.6110.502@pc.kolivas.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 09:34:20AM +1000, Con Kolivas wrote:
> Andrew Morton writes:
> 
> >Con Kolivas <kernel@kolivas.org> wrote:
> >>
> >>> A scan of the change logs for swappiness related changes shows nothing 
> >>that > might explain these changes.  My question is:  "Is this change in 
> >> behavior
> >> > deliberate, or just a side effect of other changes that were made in 
> >> the vm?" > and "What kind of swappiness behavior might I expect to find 
> >> in future kernels?".
> >>
> >> The change was not deliberate but there have been some other people 
> >> report significant changes in the swappiness behaviour as well (see 
> >> archives). It has usually been of the increased swapping variety lately. 
> >> It has been annoying enough to the bleeding edge desktop users for a 
> >> swag of out-of-tree hacks to start appearing (like mine).
> >
> >All of which is largely wasted effort.  It would be much more useful to get
> >down and identify which patch actually caused the behavioural change.
> 
> I don't disagree. Is there anyone who has the time and is willing to do the 
> regression testing? This is a general appeal to the mailing list.

Hi kernel fellows,

I volunteer. I'll try something tomorrow to compare swappiness of older kernels like  
2.6.5 and 2.6.6, which were fine on SGI's Altix tests, up to current newer kernels 
(on small memory boxes of course).

Someone needs to write a vmstat-like tool to parse /proc/vmstat. 
The statistics in there allows us to watch the behaviour of VM
page reclaim code.

Con, if you could compile a list of reports we would be very grateful.

