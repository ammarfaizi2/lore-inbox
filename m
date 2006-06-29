Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWF2UIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWF2UIe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWF2UIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:08:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10122 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932390AbWF2UId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:08:33 -0400
Date: Thu, 29 Jun 2006 13:06:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] kernel/sys.c: remove unused exports
Message-Id: <20060629130633.3da327b6.akpm@osdl.org>
In-Reply-To: <20060629195828.GF19712@stusta.de>
References: <20060629191940.GL19712@stusta.de>
	<20060629123608.a2a5c5c0.akpm@osdl.org>
	<20060629124400.ee22dfbf.akpm@osdl.org>
	<20060629195828.GF19712@stusta.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 21:58:28 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> On Thu, Jun 29, 2006 at 12:44:00PM -0700, Andrew Morton wrote:
> > On Thu, 29 Jun 2006 12:36:08 -0700
> > Andrew Morton <akpm@osdl.org> wrote:
> > 
> > > On Thu, 29 Jun 2006 21:19:40 +0200
> > > Adrian Bunk <bunk@stusta.de> wrote:
> > > 
> > > > This patch removes the following unused exports:
> > > > - EXPORT_SYMBOL:
> > > >   - in_egroup_p
> > > > - EXPORT_SYMBOL_GPL's:
> > > >   - kernel_restart
> > > >   - kernel_halt
> > > 
> > > Switch 'em to EXPORT_UNUSED_SYMBOL and I'll stop dropping your patches ;)
> > > 
> > 
> > If doing this, I'd suggest it be done thusly:
> > 
> > EXPORT_UNUSED_SYMBOL(in_egroup_p);	/* June 2006 */
> > 
> > to aid later decision-making.
> 
> I had some bad experiences with following processes you suggest the 
> doesn't remove the symbol immediately:
> 
> As you wanted me to do, I scheduled the EXPORT_SYMBOL(insert_resource) 
> for removal on 2 May 2005 with both __deprecated_for_modules and an 
> entry in feature-removal-schedule.txt with the target date April 2006.
> 
> On 11 Apr 2006, I sent the patch to implement this scheduled removal.
> 
> As of today, the latter patch is still stuck in -mm (which isn't better 
> than having it dropped) although it's long overdue.

Blame Greg ;)

> Do you understand why I distrust your "to aid later decision-making"?

You'll cope.

> Can you state publically "If there's still no in-kernel user after six 
> months, the removal is automatically ACK'ed."?

6 or 12.  We haven't decided.  6 sounds OK.  If nobody complains.  If
they do, we rethink a particular export.
