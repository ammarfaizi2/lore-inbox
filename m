Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161122AbWJXRvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161122AbWJXRvs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 13:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbWJXRvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 13:51:48 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:21122 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161122AbWJXRvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 13:51:47 -0400
Date: Tue, 24 Oct 2006 10:52:12 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20061024175212.GA17376@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20061023053223.GC17633@us.ibm.com> <Pine.LNX.4.44L0.0610231005280.6401-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0610231005280.6401-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 10:07:28AM -0400, Alan Stern wrote:
> On Sun, 22 Oct 2006, Paul E. McKenney wrote:
> 
> > How about ld_i(A) => ld_j(A)?  This would say that both loads corresponded
> > to the same store.
> 
> > > How about this instead: "A==>B" means that B sees the value stored by A,
> > > and "A==B" means that A and B are both loads and they see the value from
> > > the same store.  That way we avoid putting a load on the left side of
> > > "==>".
> > 
> > My concern is that "==" might also have connotations of equal values from
> > distinct stores.
> 
> Okay, here's another suggestion: ld_i(A) <=> ld_j(A).  This avoids 
> connotations of ordering and indicates the symmetry of the relation: both 
> loads return data from the same store.

Good point -- will try something like this.

						Thanx, Paul
