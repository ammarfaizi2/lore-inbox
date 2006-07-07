Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWGGVAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWGGVAo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 17:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWGGVAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 17:00:44 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:57362 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932267AbWGGVAo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 17:00:44 -0400
Date: Fri, 7 Jul 2006 17:00:43 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Adrian Bunk <bunk@stusta.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC: 2.6 patch] remove kernel/kthread.c:kthread_stop_sem()
In-Reply-To: <20060707135816.6f1c02bd.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0607071658380.9993-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006, Andrew Morton wrote:

> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > This patch moves the otherwise unused kthread_stop_sem() into 
> > kthread_stop().
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > ---
> > 
> > This patch was already sent on:
> > - 29 Jun 2006
> > 
> >  include/linux/kthread.h |   12 ------------
> >  kernel/kthread.c        |   14 ++------------
> >  2 files changed, 2 insertions(+), 24 deletions(-)
> > 
> 
> Hum, OK.  That's basically a `patch -R' of Alan's
> "[patch] Add kthread_stop_sem()".
> 
> Alan, are you OK with reverting that?

Yes.  I wrote it originally for use with the SCSI error-handler thread,
but then James Bottomley changed it so that it didn't wait on a semaphore.  
So if nobody else is using it, kthread_stop_sem() can go.

Alan Stern

