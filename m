Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbVI2Xka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbVI2Xka (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbVI2Xk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:40:29 -0400
Received: from lead.cat.pdx.edu ([131.252.208.91]:10482 "EHLO lead.cat.pdx.edu")
	by vger.kernel.org with ESMTP id S1751368AbVI2Xk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:40:28 -0400
Date: Thu, 29 Sep 2005 16:39:57 -0700 (PDT)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200509292339.j8TNdvKc019657@rastaban.cs.pdx.edu>
To: herbert@gondor.apana.org.au
Cc: Robert.Olsson@data.slu.se, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, paulmck@us.ibm.com,
       walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] identify in_dev_get rcu read-side critical sections
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  > From suzannew Thu Sep 29 16:30:28 2005

  > > From: Herbert Xu 30 Sep 2005 07:28

  > > BTW, could you please move the rcu_dereference in in_dev_get()
  > > into the if clause? The barrier is not needed when ip_ptr is
  > > NULL.

  > The trouble with that may be that there are three events, the
  > dereference, the assignment, and the conditional test.  The
  > rcu_dereference() is meant to assure deferred destruction
  > throughout.

Sorry, I was thinking in terms of the rcu_read_lock, so this is misstated.
