Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbULHTYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbULHTYK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 14:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbULHTXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 14:23:15 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:5119 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261327AbULHTWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 14:22:30 -0500
Subject: Re: [RFC] new timeofday core subsystem (v.A1)
From: john stultz <johnstul@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0412081043031.27324@schroedinger.engr.sgi.com>
References: <1102470914.1281.27.camel@cog.beaverton.ibm.com>
	 <1102470997.1281.30.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0412081043031.27324@schroedinger.engr.sgi.com>
Content-Type: text/plain
Message-Id: <1102533749.1281.94.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 08 Dec 2004 11:22:29 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 10:44, Christoph Lameter wrote:
> On Tue, 7 Dec 2004, john stultz wrote:
> 
> > +struct timesource_t {
> > +	char* name;
> > +	int priority;
> > +	enum {
> > +		TIMESOURCE_FUNCTION,
> > +		TIMESOURCE_MMIO_32,
> > +		TIMESOURCE_MMIO_64
> > +	} type;
> > +	cycle_t (*read_fnct)(void);
> > +	void* ptr;
> > +	cycle_t mask;
> > +	u32 mult;
> > +	u32 shift;
> > +};
> 
> Maybe add TIMESOURCE_CPU or so? How can one specify a time source in a
> cpu register?

Yea, for now its a function. I was thinking that get_cycles() could be
used as an arch independent way to do this. 

Good suggestion! 
Thanks!
-john

