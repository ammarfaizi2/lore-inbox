Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWIHV0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWIHV0G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 17:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWIHV0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 17:26:06 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:16389 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751206AbWIHV0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 17:26:03 -0400
Date: Fri, 8 Sep 2006 17:26:01 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Oliver Neukum <oliver@neukum.org>
cc: paulmck@us.ibm.com, David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <200609082230.22225.oliver@neukum.org>
Message-ID: <Pine.LNX.4.44L0.0609081723350.7953-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2006, Oliver Neukum wrote:

> It seems you are correct.
> Therefore the correct code on CPU 1 would be:
> 
> y = -1;
> b = 1;
> //mb();
> //x = a;
> while (y < 0) relax();
> 
> mb();
> x = a;
> 
> assert(x==1 || y==1);   //???
> 
> And yes, it is confusing. I've been forced to change my mind twice.

Again you have misunderstood.  The original code was _not_ incorrect.  I 
was asking: Given the code as stated, would the assertion ever fail?

The code _was_ correct for my purposes, namely, to illustrate a technical 
point about the behavior of memory barriers.

Alan

