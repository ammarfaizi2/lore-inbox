Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbWIKQuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbWIKQuJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 12:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbWIKQuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 12:50:09 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:48135 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S964925AbWIKQuI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 12:50:08 -0400
Date: Mon, 11 Sep 2006 12:50:07 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: Oliver Neukum <oliver@neukum.org>, David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <20060911162059.GA1496@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0609111246110.10623-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2006, Paul E. McKenney wrote:

> This is a summary of the Linux memory-barrier semantics as I understand
> them:
> 
> 1.	A given CPU will always perceive its own memory operations
> 	as occuring in program order.
> 
> 2.	All stores to a given single memory location will be perceived
> 	as having occurred in the same order by all CPUs.  This is
> 	"coherence".  (And this is the property that I was forgetting
> 	about when I first looked at your second example.)
...

This can't be right.  Together 1 and 2 would obviate the need for wmb().  
The CPU doing "STORE A; STORE B" will always see the operations occuring
in program order by 1, and hence every other CPU would always see them
occurring in the same order by 2 -- even without wmb().

Either 2 is too strong, or else what you mean by "perceived" isn't 
sufficiently clear.

Alan Stern

