Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbWIKTDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbWIKTDp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 15:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWIKTDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 15:03:45 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:63382 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964953AbWIKTDo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 15:03:44 -0400
Date: Mon, 11 Sep 2006 12:04:31 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oliver@neukum.org>,
       David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20060911190431.GC1295@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <Pine.LNX.4.44L0.0609111246110.10623-100000@iolanthe.rowland.org> <DA530D09-FD88-4BAF-996B-00E900F6CA51@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DA530D09-FD88-4BAF-996B-00E900F6CA51@kernel.crashing.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2006 at 07:23:49PM +0200, Segher Boessenkool wrote:
> >This can't be right.  Together 1 and 2 would obviate the need for  
> >wmb().
> >The CPU doing "STORE A; STORE B" will always see the operations  
> >occuring
> >in program order by 1, and hence every other CPU would always see them
> >occurring in the same order by 2 -- even without wmb().
> >
> >Either 2 is too strong, or else what you mean by "perceived" isn't
> >sufficiently clear.
> 
> 2. is only for multiple stores to a _single_ memory location -- you
> use wmb() to order stores to _separate_ memory locations.

Precisely!!!

						Thanx, Paul
