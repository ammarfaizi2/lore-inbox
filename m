Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269512AbTGJSeL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 14:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269530AbTGJSeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 14:34:11 -0400
Received: from cerebus.immunix.com ([198.145.28.33]:29432 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S269512AbTGJSeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 14:34:06 -0400
Date: Thu, 10 Jul 2003 11:45:58 -0700
From: Chris Wright <chris@wirex.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>,
       Jeff Muizelaar <kernel@infidigm.net>
Subject: Re: [PATCH] add seq file helpers from 2.5 (fwd)
Message-ID: <20030710114558.B29562@figure1.int.wirex.com>
References: <Pine.LNX.4.55L.0307100000100.6316@freak.distro.conectiva> <20030710112807.A29562@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030710112807.A29562@figure1.int.wirex.com>; from chris@wirex.com on Thu, Jul 10, 2003 at 11:28:07AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Wright (chris@wirex.com) wrote:
> * Marcelo Tosatti (marcelo@conectiva.com.br) wrote:
> > +int single_open(struct file *file, int (*show)(struct seq_file *, void*), void *data)
> > +{
> > +	struct seq_operations *op = kmalloc(sizeof(*op), GFP_KERNEL);
> > +	int res = -ENOMEM;
> > +
> > +	if (op) {
> > +		op->start = single_start;
> > +		op->next = single_next;
> > +		op->stop = single_stop;
> > +		op->show = show;
> > +		res = seq_open(file, op);
> 
> Any reason not to simply allocate static ops struct?  As in:

Bah, nevermind, I didn't look closely enough to see that show is
dynamic here (not to mention it is simple straight backport).  Sorry for
senseless noise ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
