Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755768AbWKQSIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755768AbWKQSIB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 13:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755759AbWKQSIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 13:08:00 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:35036 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1755766AbWKQSH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 13:07:59 -0500
Date: Fri, 17 Nov 2006 13:07:59 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Daniel Walker <dwalker@mvista.com>
cc: Andrew Morton <akpm@osdl.org>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Jens Axboe <axboe@kernel.dk>, Christoph Lameter <clameter@sgi.com>,
       Pedro Roque <roque@di.fc.ul.pt>,
       "David S. Miller" <davem@davemloft.net>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Allow NULL pointers in percpu_free
In-Reply-To: <1163785653.3097.9.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0611171307180.2627-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006, Daniel Walker wrote:

> On Fri, 2006-11-17 at 12:36 -0500, Alan Stern wrote:
> 
> >  void percpu_free(void *__pdata)
> >  {
> > +	if (!__pdata)
> > +		return;
> 
> Should be unlikely() right?

It certainly could be.  I tend not to put such annotations in my code, but 
it wouldn't hurt.

Alan Stern

