Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWBXLRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWBXLRU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 06:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWBXLRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 06:17:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48617 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751010AbWBXLRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 06:17:19 -0500
Date: Fri, 24 Feb 2006 06:16:56 -0500
From: Alan Cox <alan@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com,
       mchehab@infradead.org, akpm@osdl.org
Subject: Re: + add-cpia2-camera-support.patch added to -mm tree
Message-ID: <20060224111656.GA3136@devserv.devel.redhat.com>
References: <200602240049.k1O0nuQn023548@shell0.pdx.osdl.net> <1140772015.2874.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140772015.2874.14.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 10:06:55AM +0100, Arjan van de Ven wrote:
> you are adding rvmalloc copy number 14; seems you own the task to make
> it generic now ;)
> Also I thought SetPageReserved and friends are deprecated :)

Heading that way, which is fine by me.

> > +struct camera_data {
> > +	/* locks */
> > +	struct semaphore busy_lock;	/* guard against SMP multithreading */
> > +	struct v4l2_prio_state prio;
> > +
> 
> please make this use mutexes; adding new semaphores for no reason is not
> a good idea...

Good idea.
