Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268915AbRG0SBu>; Fri, 27 Jul 2001 14:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268917AbRG0SBk>; Fri, 27 Jul 2001 14:01:40 -0400
Received: from e22.nc.us.ibm.com ([32.97.136.228]:8660 "EHLO e22.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268915AbRG0SB3>;
	Fri, 27 Jul 2001 14:01:29 -0400
Date: Fri, 27 Jul 2001 11:01:00 -0700 (PDT)
From: Sridhar Samudrala <samudrala@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Sridhar Samudrala <samudrala@us.ibm.com>, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org, lartc@mailman.ds9a.nl,
        diffserv-general@lists.sourceforge.net, kuznet@ms2.inr.ac.ru,
        rusty@rustcorp.com.au
Subject: Re: [PATCH] Inbound Connection Control mechanism: Prioritized Accept
In-Reply-To: <E15QBMf-00066p-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0107271036390.14246-100000@w-sridhar2.des.sequent.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

There are couple of reasons why prioritization in kernel works better than at 
user level. 
* The kernel mechanisms are more efficient and scalable than the user space
  mechanism. Non compliant connection requests are discarded earlier reducing the
  queuing time of the compliant requests, in particular less CPU is consumed and
  the context switch to userspace is avoided. 
* Doing it in user space requires changes to existing applications which is not
  always possible.

Thanks
Sridhar

On Fri, 27 Jul 2001, Alan Cox wrote:

> > The documentation on HOWTO use this patch and the test results which show an
> > improvement in connection rate for higher priority classes can be found at our
> > project website.
> >         http://oss.software.ibm.com/qos
> > 
> > We would appreciate any comments or suggestions.
> 
> Simple question.
> 
> How is this different from having a single userspace thread in your
> application which accepts connections as they come in and then hands them
> out in an order it chooses, if need be erorring and closing some ?
> 
> Alan
> 

