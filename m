Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWDZRQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWDZRQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 13:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWDZRQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 13:16:29 -0400
Received: from smtp-2.llnl.gov ([128.115.3.82]:2770 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S932338AbWDZRQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 13:16:29 -0400
From: Dave Peterson <dsp@llnl.gov>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/2] mm: serialize OOM kill operations
Date: Wed, 26 Apr 2006 10:15:28 -0700
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, riel@surriel.com, akpm@osdl.org
References: <200604251701.31899.dsp@llnl.gov> <p73k69d7xl8.fsf@bragg.suse.de>
In-Reply-To: <p73k69d7xl8.fsf@bragg.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604261015.28922.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 April 2006 21:46, Andi Kleen wrote:
> Dave Peterson <dsp@llnl.gov> writes:
> > Index: git7-oom/include/linux/sched.h
> > ===================================================================
> > --- git7-oom.orig/include/linux/sched.h	2006-04-25 16:19:40.000000000
> > -0700 +++ git7-oom/include/linux/sched.h	2006-04-25 16:21:48.000000000
> > -0700 @@ -350,6 +350,8 @@ struct mm_struct {
> >  	/* aio bits */
> >  	rwlock_t		ioctx_list_lock;
> >  	struct kioctx		*ioctx_list;
> > +
> > +	int oom_notify;
>
> That wastes 4 bytes for a single bit. Please put a flag into some of the
> existing flag bitmaps instead.

Any suggestions for a location?
