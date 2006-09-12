Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965126AbWILJBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965126AbWILJBw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 05:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWILJBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 05:01:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8604 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965126AbWILJBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 05:01:50 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060911162059.GA1496@us.ibm.com> 
References: <20060911162059.GA1496@us.ibm.com>  <200609090049.20416.oliver@neukum.org> <Pine.LNX.4.44L0.0609082216070.8541-100000@netrider.rowland.org> 
To: paulmck@us.ibm.com
Cc: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oliver@neukum.org>,
       David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 12 Sep 2006 10:01:43 +0100
Message-ID: <32145.1158051703@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney <paulmck@us.ibm.com> wrote:

> 2.	All stores to a given single memory location will be perceived
> 	as having occurred in the same order by all CPUs.

Does that take into account a CPU combining or discarding coincident memory
operations?

For instance, a CPU asked to issue two writes to the same location may discard
the first if it hasn't done it yet.

David
