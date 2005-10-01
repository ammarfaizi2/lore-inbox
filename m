Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbVJAShm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVJAShm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 14:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbVJAShm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 14:37:42 -0400
Received: from iron.cat.pdx.edu ([131.252.208.92]:23995 "EHLO iron.cat.pdx.edu")
	by vger.kernel.org with ESMTP id S1750766AbVJAShm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 14:37:42 -0400
Date: Sat, 1 Oct 2005 11:37:14 -0700 (PDT)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200510011837.j91IbE01012915@rastaban.cs.pdx.edu>
To: herbert@gondor.apana.org.au
Cc: Robert.Olsson@data.slu.se, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, paulmck@us.ibm.com,
       walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] identify in_dev_get rcu read-side critical sections
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please excuse this restatement of an earlier concern.

  > From suzannew Sat Oct  1 11:00:28 2005

  > With the spotlight leaving in_dev_get, we have the parallel question 
  > of in_dev_put() and __in_dev_put()  both defined with refcnt 
  > decrement, but the preceding underscore may lend itself to an
  > inadvertant pairing and refcnt inaccuracy.

Dave Miller already addressed this question in 
http://www.ussg.iu.edu/hypermail/linux/kernel/0509.3/0757.html 

  > It may not be reasonable to rename __in_dev_put for its parallel definition
  > since its current usage is with __in_dev_get_rtnl() which does not increment 
  > refcnt. 

But the following may be worth considering.

  > It is also probably good to retain the old __in_dev_get()
and deprecate it.

Thank you.
