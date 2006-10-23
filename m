Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWJWOHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWJWOHa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 10:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWJWOHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 10:07:30 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:57106 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S964863AbWJWOH3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 10:07:29 -0400
Date: Mon, 23 Oct 2006 10:07:28 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <20061023053223.GC17633@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0610231005280.6401-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Oct 2006, Paul E. McKenney wrote:

> How about ld_i(A) => ld_j(A)?  This would say that both loads corresponded
> to the same store.

> > How about this instead: "A==>B" means that B sees the value stored by A,
> > and "A==B" means that A and B are both loads and they see the value from
> > the same store.  That way we avoid putting a load on the left side of
> > "==>".
> 
> My concern is that "==" might also have connotations of equal values from
> distinct stores.

Okay, here's another suggestion: ld_i(A) <=> ld_j(A).  This avoids 
connotations of ordering and indicates the symmetry of the relation: both 
loads return data from the same store.

Alan

