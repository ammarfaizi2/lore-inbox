Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUGLSck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUGLSck (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 14:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUGLSck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 14:32:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36299 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261159AbUGLScg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 14:32:36 -0400
Date: Mon, 12 Jul 2004 14:29:16 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Christoph Hellwig <hch@infradead.org>
cc: Jakub Jelinek <jakub@redhat.com>, davidm@hpl.hp.com,
       suresh.b.siddha@intel.com, jun.nakajima@intel.com,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: serious performance regression due to NX patch
In-Reply-To: <20040712182431.GB28281@infradead.org>
Message-ID: <Pine.LNX.4.58.0407121428270.22224@devserv.devel.redhat.com>
References: <200407100528.i6A5SF8h020094@napali.hpl.hp.com>
 <Pine.LNX.4.58.0407110437310.26065@devserv.devel.redhat.com>
 <Pine.LNX.4.58.0407110536130.2248@devserv.devel.redhat.com>
 <Pine.LNX.4.58.0407110550340.4229@devserv.devel.redhat.com>
 <20040711123803.GD21264@devserv.devel.redhat.com>
 <Pine.LNX.4.58.0407121402160.2451@devserv.devel.redhat.com>
 <20040712182431.GB28281@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Jul 2004, Christoph Hellwig wrote:

> On Mon, Jul 12, 2004 at 02:08:11PM -0400, Ingo Molnar wrote:
> > the #ifdef could be made an arch inline or define. But it's really
> > academic as only ia64 seems to have this problem. So i'd suggest the patch
> > below.
> 
> Well, it's not.  We probably want each new port start to have the ia64
> behaviour, so it should be abstracted out nicer.

is it an issue? Each new port will have PT_GNU_STACK, unless they base
themselves on old compilers.

	Ingo
