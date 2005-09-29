Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbVI3AAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVI3AAh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 20:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVI3AAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 20:00:37 -0400
Received: from mournblade.cat.pdx.edu ([131.252.208.27]:30141 "EHLO
	mournblade.cat.pdx.edu") by vger.kernel.org with ESMTP
	id S932395AbVI3AAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 20:00:36 -0400
Date: Thu, 29 Sep 2005 16:59:56 -0700 (PDT)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200509292359.j8TNxuxD019838@rastaban.cs.pdx.edu>
To: herbert@gondor.apana.org.au
Cc: Robert.Olsson@data.slu.se, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, paulmck@us.ibm.com,
       walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] identify in_dev_get rcu read-side critical sections
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to be thinking on-line, but if you mean this:

  if (in_dev = rcu_dereference(dev->ip_ptr))

I think that's fine.

  > From suzannew Thu Sep 29 16:39:57 2005

  >   > From suzannew Thu Sep 29 16:30:28 2005

  >   > > From: Herbert Xu 30 Sep 2005 07:28

  >   > > BTW, could you please move the rcu_dereference in in_dev_get()
  >   > > into the if clause? The barrier is not needed when ip_ptr is
  >   > > NULL.

  >   > The trouble with that may be that there are three events, the
  >   > dereference, the assignment, and the conditional test.  The
  >   > rcu_dereference() is meant to assure deferred destruction
  >   > throughout.

