Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWHRIjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWHRIjH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 04:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWHRIjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 04:39:06 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:44444 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750829AbWHRIjF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 04:39:05 -0400
Subject: Re: [ckrm-tech] [PATCH 2/7] UBC: core (structures, API)
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrey Savochkin <saw@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@sw.ru>, Christoph Hellwig <hch@infradead.org>,
       devel@openvz.org, rohitseth@google.com, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <20060818113525.A11407@castle.nmd.msu.ru>
References: <44E33893.6020700@sw.ru> <44E33BB6.3050504@sw.ru>
	 <1155751868.22595.65.camel@galaxy.corp.google.com> <44E458C4.9030902@sw.ru>
	 <20060817223137.ca4951ff.akpm@osdl.org>
	 <20060818113525.A11407@castle.nmd.msu.ru>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 01:26:03 -0700
Message-Id: <1155889563.2510.303.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 11:35 +0400, Andrey Savochkin wrote:
> On Thu, Aug 17, 2006 at 10:31:37PM -0700, Andrew Morton wrote:
> > On Thu, 17 Aug 2006 15:53:40 +0400
> > Kirill Korotaev <dev@sw.ru> wrote:
> > 
> > > >>+struct user_beancounter
> > > >>+{
> > > >>+	atomic_t		ub_refcount;
> > > >>+	spinlock_t		ub_lock;
> > > >>+	uid_t			ub_uid;
> > > > 
> > > > 
> > > > Why uid?  Will it be possible to club processes belonging to different
> > > > users to same bean counter.
> > > oh, its a misname. Should be ub_id. it is ID of user_beancounter
> > > and has nothing to do with user id.
> > 
> > But it uses a uid_t.  That's more than a misnaming?
> 
> It used to be uid-related in ancient times when the notion of container
> hadn't formed up.
> "user" part of user_beancounter name has the same origin :)

Is it similarly irrelevant now? If so perhaps a big rename could be used
to make the names clearer (s/user_//, s/ub_/bc_/, ...).

<snip>

Cheers,
	-Matt Helsley

