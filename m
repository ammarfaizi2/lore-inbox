Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWIHVqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWIHVqH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 17:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWIHVqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 17:46:07 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:34698 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S1751205AbWIHVqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 17:46:05 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Uses for memory barriers
Date: Fri, 8 Sep 2006 23:46:20 +0200
User-Agent: KMail/1.8
Cc: paulmck@us.ibm.com, David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0609081723350.7953-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0609081723350.7953-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609082346.20740.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 8. September 2006 23:26 schrieb Alan Stern:
> On Fri, 8 Sep 2006, Oliver Neukum wrote:
> 
> > It seems you are correct.
> > Therefore the correct code on CPU 1 would be:
> > 
> > y = -1;
> > b = 1;
> > //mb();
> > //x = a;
> > while (y < 0) relax();
> > 
> > mb();
> > x = a;
> > 
> > assert(x==1 || y==1);   //???
> > 
> > And yes, it is confusing. I've been forced to change my mind twice.
> 
> Again you have misunderstood.  The original code was _not_ incorrect.  I 
> was asking: Given the code as stated, would the assertion ever fail?

I claim the right to call code that fails its own assertions incorrect. :-)

> The code _was_ correct for my purposes, namely, to illustrate a technical 
> point about the behavior of memory barriers.

I would say that the code may fail the assertion purely based
on the formal definition of a memory barrier. And do so in a subtle
and inobvious way.

	Regards
		Oliver
