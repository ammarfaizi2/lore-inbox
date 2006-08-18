Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWHRHf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWHRHf1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 03:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWHRHf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 03:35:27 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:3600 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S1750984AbWHRHf0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 03:35:26 -0400
Message-ID: <20060818113525.A11407@castle.nmd.msu.ru>
Date: Fri, 18 Aug 2006 11:35:25 +0400
From: Andrey Savochkin <saw@sw.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Kirill Korotaev <dev@sw.ru>, rohitseth@google.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, devel@openvz.org,
       Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 2/7] UBC: core (structures, API)
References: <44E33893.6020700@sw.ru> <44E33BB6.3050504@sw.ru> <1155751868.22595.65.camel@galaxy.corp.google.com> <44E458C4.9030902@sw.ru> <20060817223137.ca4951ff.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20060817223137.ca4951ff.akpm@osdl.org>; from "Andrew Morton" on Thu, Aug 17, 2006 at 10:31:37PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 10:31:37PM -0700, Andrew Morton wrote:
> On Thu, 17 Aug 2006 15:53:40 +0400
> Kirill Korotaev <dev@sw.ru> wrote:
> 
> > >>+struct user_beancounter
> > >>+{
> > >>+	atomic_t		ub_refcount;
> > >>+	spinlock_t		ub_lock;
> > >>+	uid_t			ub_uid;
> > > 
> > > 
> > > Why uid?  Will it be possible to club processes belonging to different
> > > users to same bean counter.
> > oh, its a misname. Should be ub_id. it is ID of user_beancounter
> > and has nothing to do with user id.
> 
> But it uses a uid_t.  That's more than a misnaming?

It used to be uid-related in ancient times when the notion of container
hadn't formed up.
"user" part of user_beancounter name has the same origin :)

Now ub_id_t or something like that would be the most logical type.

	Andrey
