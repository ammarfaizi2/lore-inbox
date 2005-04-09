Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVDIMW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVDIMW3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 08:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVDIMW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 08:22:29 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:32746 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261337AbVDIMW0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 08:22:26 -0400
Date: Sat, 9 Apr 2005 14:20:45 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, antonb@au1.ibm.com, davej@codemonkey.org.uk,
       hpa@zytor.com, len.brown@intel.com, andmike@us.ibm.com, rth@twiddle.net,
       rusty@au1.ibm.com, schwidefsky@de.ibm.com, jgarzik@pobox.com
Subject: Re: [RFC,PATCH 3/4] Change synchronize_kernel to _rcu and _sched
Message-ID: <20050409122045.GA6073@electric-eye.fr.zoreil.com>
References: <20050408010949.GB1299@us.ibm.com> <Pine.LNX.4.44.0504091047510.18763-100000@dbl.q-ag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0504091047510.18763-100000@dbl.q-ag.de>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> :
> [Jeff added to cc list - it's a network driver question]
[...]
> I haven't read the whole driver, but what about
> 	spin_unlock_wait(&dev->xmit_lock);
> ?

The race here is a dev->close() against dev->hard_start_xmit() one where
dev->hard_start_xmit() does not do any locking at all.

(so far, so good...)

--
Ueimor
