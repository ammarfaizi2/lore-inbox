Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272222AbTHRRR2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 13:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272223AbTHRRR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 13:17:28 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:20646
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S272222AbTHRRRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 13:17:24 -0400
Date: Mon, 18 Aug 2003 16:16:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, dipankar@in.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       paulmck@us.ibm.com
Subject: Re: [PATCH] RCU: Reduce size of rcu_head 1 of 2
Message-ID: <20030818141606.GU7862@dualathlon.random>
References: <1059830126.19819.8.camel@dhcp22.swansea.linux.org.uk> <20030808193441.56F452C25E@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030808193441.56F452C25E@lists.samba.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 08, 2003 at 12:21:04PM +1000, Rusty Russell wrote:
> There are two patches.  Both reduce the size of the "struct rcu_head".
> One simply changes the struct rcu_head from a double linked list to a
> single linked list.  The other eliminates the "void *data" arg, and
> changes the prototype of the call_rcu() function to take a pointer to
> the struct rcu_head, rather than a user-defined data ptr.
> 
> It is the latter that I am concerned about changing mid-stable-series.

given the number of users (a dozen) I wouldn't be concerned about the
API change either. Much better to change it now that there arne't out of
the tree users yet. IMHO kernel internal API changes aren't a problem if
there are few users all in tree like in this case.

Andrea
