Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264634AbTE1Jcg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 05:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264635AbTE1Jcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 05:32:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20687 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264634AbTE1Jce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 05:32:34 -0400
Date: Wed, 28 May 2003 11:45:35 +0200
From: Jens Axboe <axboe@suse.de>
To: Ragnar Hojland Espinosa <ragnar@linalco.com>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       manish <manish@storadinc.com>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030528094535.GI845@suse.de>
References: <3ED2DE86.2070406@storadinc.com> <3ED3A2AB.3030907@gmx.net> <3ED3A55E.8080807@storadinc.com> <200305271954.11635.m.c.p@wolk-project.de> <20030528093654.GA20687@linalco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030528093654.GA20687@linalco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28 2003, Ragnar Hojland Espinosa wrote:
> On Tue, May 27, 2003 at 08:04:49PM +0200, Marc-Christian Petersen wrote:
> > 
> > ALL: Anyone who has this kind of pauses/stops/mouse is dead/keyboard is dead/:
> >      speak _NOW_ please, doesn't matter who you are!
> 
> FWIW, me too.
> 
> Actually it just happens in the fixing stage when burning prebuilt iso
> images from the hard disk (same IDE channel as the burner, 2.4.20)
> Having a completely frozen machine under X was quite panic inducing ;)
> 
> A friend told me they also get regular "pauses" when quitting from
> vmware.

Lemme guess, hard drive on the same channel as the burner? There's
nothing we can do about that, hardware limitation. The reason you see it
during fixation is because that's one long single command, and we cannot
preempt the channel and service requests while that is going on.

-- 
Jens Axboe

