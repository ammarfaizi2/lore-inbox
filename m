Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264407AbTCXUb7>; Mon, 24 Mar 2003 15:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264409AbTCXUb7>; Mon, 24 Mar 2003 15:31:59 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:12425 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264407AbTCXUb6>; Mon, 24 Mar 2003 15:31:58 -0500
Date: Mon, 24 Mar 2003 20:42:52 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: cyclades region handling updates from 2.4
Message-ID: <20030324204252.GA21521@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <200303241641.h2OGft35008188@deviant.impure.org.uk> <20030324143758.66ed03fe.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030324143758.66ed03fe.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 02:37:58PM -0800, Andrew Morton wrote:
 > davej@codemonkey.org.uk wrote:
 > >
 > > -static struct timer_list cyz_timerlist = TIMER_INITIALIZER(cyz_poll, 0, 0);
 > > +static struct timer_list cyz_timerlist = {
 > > +	.function = cyz_poll
 > > +};
 > 
 > errr, bit of regression there.  The spinlock in the timer is no longer
 > initialised.

erk, bad merge on my part after your initial fix there.
I'll send a backout patch along with the bit putting the maintainers
name right.

		Dave

