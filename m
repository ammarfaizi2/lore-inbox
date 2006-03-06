Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWCFLRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWCFLRe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 06:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWCFLRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 06:17:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57792 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750777AbWCFLRe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 06:17:34 -0500
Date: Mon, 6 Mar 2006 03:15:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: greg@kroah.com, torvalds@osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: oops in choose_configuration()
Message-Id: <20060306031550.15f76dc7.akpm@osdl.org>
In-Reply-To: <9a8748490603060304q2fa22a4fq6d4abf1a8e990482@mail.gmail.com>
References: <20060304121723.19fe9b4b.akpm@osdl.org>
	<Pine.LNX.4.64.0603041235110.22647@g5.osdl.org>
	<20060304213447.GA4445@kroah.com>
	<20060304135138.613021bd.akpm@osdl.org>
	<20060304221810.GA20011@kroah.com>
	<20060305154858.0fb0006a.akpm@osdl.org>
	<9a8748490603060304q2fa22a4fq6d4abf1a8e990482@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jesper Juhl" <jesper.juhl@gmail.com> wrote:
>
> On 3/6/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > Might as well cc the list on this, so there's a record...
> >
> > For several days I've been getting repeatable oopses in the -mm kernel.
> > They occur once per ~30 boots, during initscripts.
> >
> [snip]
> 
> Hi Andrew,
> 
> I send a mail to the list yesterday (with you and a few other people
> on cc) about Slab corruption in 2.6.16-5c5-mm2.
> You have a problem with memory corruption and I'm seeing slab
> corruption messages in dmesg...
> 
> Just wanted to point it out in this thread in case they are related.
> 

Yes, there have been several memory-scribblish reports.  Until this one's
found I'm not sure there's much we can do with them.

I'll do an overnight run with CONFIG_DEBUG_SLAB, see if that catches
anything.  Although AFAICT it just fixes the bug.

Beyond that, I'm rather stuck.  I'd probably have to drop a pile of sched
patches, see if that improves things for people.  But if we cannot spot a
bug in those patches then it's probably in mainline and it will bite
people in generally random and rare ways.
