Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbVJCO1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVJCO1g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 10:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbVJCO1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 10:27:35 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:34005 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932246AbVJCO1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 10:27:35 -0400
Date: Mon, 3 Oct 2005 07:28:10 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, dipankar@in.ibm.com,
       vatsa@in.ibm.com, rusty@au1.ibm.com, mingo@elte.hu,
       manfred@colorfullife.com
Subject: Re: [PATCH] RCU torture testing
Message-ID: <20051003142810.GA1300@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051001182056.GA1613@us.ibm.com> <20051002001137.GA17583@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051002001137.GA17583@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2005 at 05:11:37PM -0700, Greg KH wrote:
> On Sat, Oct 01, 2005 at 11:20:56AM -0700, Paul E. McKenney wrote:
> > +The CONFIG_RCU_TORTURE_TEST config option is available for all RCU
> > +implementations.  It makes three /proc entries available, namely: rcutw,
> > +rcutr, and rcuts.
> 
> Ick, why /proc entries, this has nothing to do with processes, right?
> Please use debugfs instead, that is what it was created for.

OK, will look into that.  At first glance, it does appear to require
quite a bit more code to make use of than did the /proc filesystem,
if you want the files to produce human-readable strings, as is appropriate
in this case.  I am looking at uhci-debug.c -- is there an example that
better matches what I am trying to do?

						Thanx, Paul
