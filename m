Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267465AbUGWBV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267465AbUGWBV7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 21:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267466AbUGWBV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 21:21:59 -0400
Received: from agora.rdrop.com ([199.26.172.34]:45068 "EHLO agora.rdrop.com")
	by vger.kernel.org with ESMTP id S267465AbUGWBV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 21:21:57 -0400
Date: Thu, 22 Jul 2004 18:21:36 -0700
From: Paul Mckenney <paulmck@agora.rdrop.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org, rusty@au1.ibm.com, faith@redhat.com,
       dipankar@in.ibm.com
Subject: Re: [RFC][PATCH] More comment improvements for RCU primitives
Message-ID: <20040723012136.GA72249@agora.rdrop.com>
References: <20040720023515.GA84746@agora.rdrop.com> <20040722112520.6b7a21b9@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722112520.6b7a21b9@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 11:25:20AM -0700, Stephen Hemminger wrote:
> On Mon, 19 Jul 2004 19:35:15 -0700
> Paul Mckenney <paulmck@agora.rdrop.com> wrote:
> 
> > Hello!
> > 
> > Here is a patch to improve the usefulness of the RCU primitives'
> > documentation.  Again, this probably interacts badly with existing
> > RCU patches, which I will fix when I incorporate feedback.
> > 
> > 						Thanx, Paul
> 
> If you are going to be this verbose (which is good), you may want to
> mention how this interacts on a UP system as well.

Good point...

My first thought would be to add a paragraph saying what happens
on a UP for call_rcu() and synchronize_kernel(), something like
for call_rcu():

	This primitive has the same effect on a UP system.
	For example, if an RCU read-side critical section
	is interrupted by a handler that invokes call_rcu(),
	the corresponding update function will be invoked
	some time after the RCU read-side critical section
	has completed, which will in turn be some time after
	the interrupt handler returns.

Does this seem reasonable?

						Thanx, Paul
