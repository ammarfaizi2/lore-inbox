Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261287AbTC0Tlt>; Thu, 27 Mar 2003 14:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261312AbTC0Tlt>; Thu, 27 Mar 2003 14:41:49 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:18193
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261287AbTC0Tlr>; Thu, 27 Mar 2003 14:41:47 -0500
Subject: Re: BUG or not? GFP_KERNEL with interrupts disabled.
From: Robert Love <rml@tech9.net>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, dane@aiinet.com, shmulik.hen@intel.com,
       bonding-devel@lists.sourceforge.net,
       bonding-announce@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       mingo@redhat.com, kuznet@ms2.inr.ac.ru
In-Reply-To: <20030327.113933.123322481.davem@redhat.com>
References: <20030327.111012.23672715.davem@redhat.com>
	 <Pine.LNX.4.44.0303271120230.31459-100000@home.transmeta.com>
	 <20030327.113933.123322481.davem@redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1048794730.775.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 27 Mar 2003 14:52:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-27 at 14:39, David S. Miller wrote:

> I hadn't considered this, good idea.  I'm trying this out right now.

I hope it works.  I have a sinking feeling we call it some places that
may have interrupts disabled...

> Someone should backport the might_sleep() stuff to 2.4.x, it's very
> useful.

Would be nice, but for the maximum effect we need kernel preemption
(which keeps track of atomicity via preempt_count).  I doubt we want to
go there for 2.4.

	Robert Love

