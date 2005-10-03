Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbVJCPt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbVJCPt1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbVJCPt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:49:26 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:16594 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932307AbVJCPt0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:49:26 -0400
Date: Mon, 3 Oct 2005 08:49:39 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       dipankar@in.ibm.com, vatsa@in.ibm.com, rusty@au1.ibm.com, mingo@elte.hu,
       manfred@colorfullife.com
Subject: Re: [PATCH] RCU torture testing
Message-ID: <20051003154939.GF1300@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051001182056.GA1613@us.ibm.com> <20051002210549.GA8503@elf.ucw.cz> <20051003143009.GB1300@us.ibm.com> <1128350188.17024.14.camel@laptopd505.fenrus.org> <20051003152602.GD1300@us.ibm.com> <1128353520.17024.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128353520.17024.19.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 05:31:59PM +0200, Arjan van de Ven wrote:
> 
> > Good point -- all I really need for module parameters is the number
> > of readers.  I should be able to have module load start the test and
> > module unload stop it (any problems with this approach?). 
> 
> only one potential gotcha; it means you can't load the system to the
> extend that the shell doesn't get cpu time otherwise the admin can never
> issue the unload. Maybe a time limit on the testing? (optional as module
> parm for all I care)

Makes sense to me!  Not an issue for the RCU torture test, but it certainly
might be for other tests.

							Thanx, Paul
