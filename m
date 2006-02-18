Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWBSA2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWBSA2i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 19:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWBSA2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 19:28:38 -0500
Received: from ozlabs.org ([203.10.76.45]:32152 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932367AbWBSA2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 19:28:37 -0500
Subject: Re: Robust futexes
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060217091307.GB22718@elte.hu>
References: <1140152271.25078.42.camel@localhost.localdomain>
	 <20060216224207.98526b40.pj@sgi.com>
	 <1140160371.25078.81.camel@localhost.localdomain>
	 <20060216232950.efa39e13.pj@sgi.com>  <20060217091307.GB22718@elte.hu>
Content-Type: text/plain
Date: Sat, 18 Feb 2006 14:53:32 +1100
Message-Id: <1140234812.2418.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-17 at 10:13 +0100, Ingo Molnar wrote:
> * Paul Jackson <pj@sgi.com> wrote:
> 
> > So the point is that we only have to cleanup the stale locks of dead 
> > threads when some other task has the misfortune of trying to take the 
> > orphaned lock and gets forced into a wait.
> > 
> > The wait call essentially becomes a "wait unless said other TID is 
> > dead, in which case, a new owner is summarily declared."
> 
> the fundamental problem i see here: how do you 'declare' a TID as dead?  
> 32-bit TIDs can be reused, quite fundamentally.

Yes.  I was asking of we actually need prefect robustness.  I'm fairly
confident that this approach would work well in practice, since if tids
are being churned, the thread with wrapped TID will exit soon anyway.

I mentioned the possibility to make sure you had considered it.

As an added bonus, the tone of the first response I received (not
yours!) reminded me why I am not subscribed to lkml...

Cheers!
Rusty.
-- 
 ccontrol: http://ozlabs.org/~rusty/ccontrol

