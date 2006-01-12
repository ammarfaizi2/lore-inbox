Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbWALFg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbWALFg3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 00:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbWALFg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 00:36:28 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:7836 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030291AbWALFg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 00:36:28 -0500
Subject: Re: [Lse-tech] Re: [ckrm-tech] Re: [PATCH 00/01] Move Exit
	Connectors
From: Matt Helsley <matthltc@us.ibm.com>
To: Keith Owens <kaos@sgi.com>
Cc: John Hesterberg <jh@sgi.com>, Jes Sorensen <jes@trained-monkey.org>,
       Shailabh Nagar <nagar@watson.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Jay Lan <jlan@engr.sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       elsa-devel@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>
In-Reply-To: <8699.1137036592@kao2.melbourne.sgi.com>
References: <8699.1137036592@kao2.melbourne.sgi.com>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 21:26:08 -0800
Message-Id: <1137043569.6673.156.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 14:29 +1100, Keith Owens wrote:
> John Hesterberg (on Wed, 11 Jan 2006 15:39:10 -0600) wrote:
> >On Wed, Jan 11, 2006 at 01:02:10PM -0800, Matt Helsley wrote:
> >> 	Have you looked at Alan Stern's notifier chain fix patch? Could that be
> >> used in task_notify?
> >
> >I have two concerns about an all-tasks notification interface.
> >First, we want this to scale, so don't want more global locks.
> >One unique part of the task notify is that it doesn't use locks.
> 
> Neither does Alan Stern's atomic notifier chain.  Indeed it cannot use
> locks, because the atomic notifier chains can be called from anywhere,
> including non maskable interrupts.  The downside is that Alan's atomic
> notifier chains require RCU.
> 
> An alternative patch that requires no locks and does not even require
> RCU is in http://marc.theaimsgroup.com/?l=linux-kernel&m=113392370322545&w=2
> 

	Interesting. Might the 'inuse' flags suffer from bouncing due to false
sharing?

Cheers,
	-Matt Helsley

