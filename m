Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbSLAREb>; Sun, 1 Dec 2002 12:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261950AbSLAREb>; Sun, 1 Dec 2002 12:04:31 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:15365 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261934AbSLAREa>;
	Sun, 1 Dec 2002 12:04:30 -0500
Date: Sun, 1 Dec 2002 10:12:27 -0800
From: Greg KH <greg@kroah.com>
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Cc: linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] LSM fix for stupid "empty" functions
Message-ID: <20021201181227.GC8829@kroah.com>
References: <20021201083056.GJ679@kroah.com> <87k7it3cbl.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k7it3cbl.fsf@goat.bogus.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 01, 2002 at 05:59:10PM +0100, Olaf Dietsche wrote:
> >  	VERIFY_STRUCT(struct security_operations, ops, err);
> 
> This shouldn't be necessary anymore.

Good point, I'll remove it.  It was a hack anyway :)

> You're patching other people's data structures. Not everybody may like
> this. Maybe it's even impossible on ROM based systems. Do you think a
> copy is doable? Just a thought.

Does the kernel work if data structures are in ROM?  I would think that
lots of variables in the kernel would have this problem :)

And yes, patching other people's data structures isn't the nicest thing
to do, but it was the simplest proposal I've come up with so far (we've
had a lot of other pretty "odd" proposals for this problem in the past.)

> >  	if (verify (ops)) {
> >  		printk (KERN_INFO "%s could not verify "
> 
> When ops is NULL, this check is too late.

Oops, forgot that, I'll go fix it up.

thanks,

greg k-h
