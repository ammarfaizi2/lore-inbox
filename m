Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVF1R6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVF1R6O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 13:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbVF1R6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 13:58:14 -0400
Received: from 65-102-103-67.albq.qwest.net ([65.102.103.67]:24999 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261334AbVF1R6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 13:58:09 -0400
Date: Tue, 28 Jun 2005 12:02:06 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, dipankar@in.ibm.com,
       ak@suse.de, akpm@osdl.org, maneesh@in.ibm.com
Subject: Re: [RFC,PATCH] RCU: clean up a few remaining synchronize_kernel()
 calls
In-Reply-To: <20050628174007.GH1294@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0506281200590.12042@montezuma.fsmlabs.com>
References: <20050618002021.GA2892@us.ibm.com>
 <Pine.LNX.4.61.0506191150300.26045@montezuma.fsmlabs.com>
 <20050627050206.GA2139@us.ibm.com> <Pine.LNX.4.61.0506271305290.12042@montezuma.fsmlabs.com>
 <20050628153257.GD1294@us.ibm.com> <Pine.LNX.4.61.0506281055260.9135@montezuma.fsmlabs.com>
 <20050628174007.GH1294@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2005, Paul E. McKenney wrote:

> awake...  How about the following instead?
> 
> 	void set_nmi_callback(nmi_callback_t callback)
> 	{
> 		rcu_assign_pointer(nmi_callback, callback);
> 	}
> 
> Similarly:
> 
> 	void unset_nmi_callback(void)
> 	{
> 		rcu_assign_pointer(nmi_callback, dummy_nmi_callback);
> 	}

Great, more API coverage is always better.

> This, combined with the rcu_dereference() in do_nmi() seem to me to
> make the usage a lot more clear.  If you agree, would you like to
> submit the patches, or should I?

You go ahead.

> > Thanks for elaborating, the examples certainly do help clarify usage.
> 
> Glad they help, will clean them up (so that the examples use
> rcu_dereference() and rcu_assign_pointer()) and submit them!

Thanks,
	Zwane

