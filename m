Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270745AbUJUPW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270745AbUJUPW0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 11:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270764AbUJUPVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 11:21:32 -0400
Received: from ipx20189.ipxserver.de ([80.190.249.56]:42630 "EHLO
	ipx20189.ipxserver.de") by vger.kernel.org with ESMTP
	id S270745AbUJUPUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 11:20:36 -0400
Date: Thu, 21 Oct 2004 18:18:42 +0300 (EAT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrea Arcangeli <andrea@novell.com>,
       Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
In-Reply-To: <1098289667.1429.52.camel@krustophenia.net>
Message-ID: <Pine.LNX.4.61.0410211815280.6913@musoma.fsmlabs.com>
References: <593560000.1094826651@[10.10.2.4]> 
 <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain> 
 <20040910151538.GA24434@devserv.devel.redhat.com>  <20040910152852.GC15643@x30.random>
  <20040910153421.GD24434@devserv.devel.redhat.com>  <20040912141701.GA21626@nocona.random>
 <622230000.1095001434@[10.10.2.4]>  <Pine.LNX.4.53.0409121133480.2297@montezuma.fsmlabs.com>
 <1098289667.1429.52.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004, Lee Revell wrote:

> Are these really "priorities" in real life?  I am not being facetious,
> this is actually a common myth among users, that you will get better
> performance by putting the device you care about on a "high priority"
> irq or tweaking the priorities in your local APIC.  My impression was
> that this is pointless because it only determines which interrupt the
> CPU sees first if they fire at _exactly_ the same time.  Since we allow
> interrupt to nest this does not matter in practice, right?

Yep, it only affects which vector gets dispatched first in the multiple 
vectors queued scenario which doesn't really matter with nesting as you 
noted.

	Zwane

