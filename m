Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423075AbWAMW7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423075AbWAMW7h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423086AbWAMW7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:59:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39130 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423087AbWAMW7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:59:32 -0500
Date: Fri, 13 Jan 2006 15:01:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: drepper@gmail.com, robustmutexes@lists.osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org, daviado@gmail.com
Subject: Re: Robust futex patch for Linux 2.6.15
Message-Id: <20060113150120.7ab2cfe4.akpm@osdl.org>
In-Reply-To: <p73lkxj22is.fsf@verdi.suse.de>
References: <b324b5ad0601131316m721f959eu37b741f9e5557a2e@mail.gmail.com>
	<20060113132704.207336d7.akpm@osdl.org>
	<p73lkxj22is.fsf@verdi.suse.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> > 
> > +static int futex_deadlock(struct rt_mutex *lock)
> > +{
> > +	DEFINE_WAIT(wait);
> > +
> > +	_raw_spin_unlock(&lock->wait_lock);
> > +	_raw_spin_unlock(&current->pi_lock);
> 
> And why is there a pi_lock if the code isn't supposed to support PI?
> 

That was a copy-n-paste from a -rt patch I happened to find.  The URL David
sent was bust, and there are various things in the directory there.  Maybe
we were supposed to look in a tarball, dunno.
