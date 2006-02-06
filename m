Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWBFIpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWBFIpn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 03:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWBFIpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 03:45:42 -0500
Received: from gold.veritas.com ([143.127.12.110]:61260 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750794AbWBFIpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 03:45:42 -0500
Date: Mon, 6 Feb 2006 08:46:07 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Pete Zaitcev <zaitcev@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stop ==== emergency
In-Reply-To: <20060205205709.0b88171b.zaitcev@redhat.com>
Message-ID: <Pine.LNX.4.61.0602060841540.6574@goblin.wat.veritas.com>
References: <mailman.1139006040.12873.linux-kernel2news@redhat.com>
 <20060205205709.0b88171b.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 06 Feb 2006 08:45:35.0707 (UTC) FILETIME=[B28742B0:01C62AF9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Feb 2006, Pete Zaitcev wrote:
> On Fri, 3 Feb 2006 21:37:09 +0000 (GMT), Hugh Dickins <hugh@veritas.com> wrote:
> 
> > +++ linux/arch/i386/kernel/traps.c	2006-02-03 09:59:37.000000000 +0000
> > @@ -166,7 +166,8 @@ static void show_trace_log_lvl(struct ta
> >  		stack = (unsigned long*)context->previous_esp;
> >  		if (!stack)
> >  			break;
> > -		printk(KERN_EMERG " =======================\n");
> > +		printk(log_lvl);
> > +		printk(" =======================\n");
> >  	}
> 
> This is wrong, Hugh. What do you think the priority of the second printk?
> It's not log_lvl, that's for sure.

Are you sure?  I've not delved into the printk code itself, but this
does follow the same pattern as in show_stack_log_lvl itself e.g. its
"Call Trace:\n" line.  (I am assuming print_context_stack ends with a
newline, as it does.)

Hugh
