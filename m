Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVBHWih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVBHWih (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 17:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVBHWhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 17:37:37 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:17288 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261644AbVBHWgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 17:36:43 -0500
Subject: Re: Merging the Suspend2 freezer implementation.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050208223241.GC1347@elf.ucw.cz>
References: <1107822206.2756.18.camel@desktop.cunninghams>
	 <20050208163644.GG1622@elf.ucw.cz>
	 <1107899999.4330.39.camel@desktop.cunninghams>
	 <20050208223241.GC1347@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1107902339.4330.74.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 09 Feb 2005 09:38:59 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-02-09 at 09:32, Pavel Machek wrote:
> Hi!
> 
> > > > The main change involves the introduction of a new SYNCTHREAD flag. We
> > > > use this to avoid deadlocking over processes that are running sys_sync
> > > > and siblings. Processes that enter those routines get the flag added,
> > > > and it's removed when they exit the sync routine. We then freeze in four
> > > > stages: 
> > > 
> > > Is SYNCTHREAD neccessary for me, too, or is it needed for suspend2, only?
> > 
> > It's necessary for reliable freezing under I/O load. Signalling the
> > non-sync threads first removes the race involved in some threads
> > submitting I/O while others are trying to sync. Try doing a dd and a
> > sync at the same time. The sync can take ages to return, worst case,
> > sometimes not until the dd is completed. (Actually, try doing anything
> > while a dd is running :>)
> 
> Okay, just attach this explanation when you are merging it otherwise
> I'll surely ask again...

Okay.

> > > > Finally I'd like to merge the support for freezer flags on workqueues.
> > 
> > No comment here? :>
> 
> :-). I forgot why it was neccessary, but I was too shy to ask
> ;-). Just attach nice explanation when you attempt to merge it.

Okay.

Thanks!

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

