Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbUKQUX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbUKQUX4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 15:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbUKQUWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 15:22:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:1254 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262442AbUKQUVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 15:21:45 -0500
Date: Wed, 17 Nov 2004 12:21:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: ak@suse.de, 76306.1226@compuserve.com, andrea@novell.com,
       linux-kernel@vger.kernel.org
Subject: Re: Dropped patch: mm/mempolicy.c:sp_lookup()
Message-Id: <20041117122123.6162fa70.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0411171938210.1809-100000@localhost.localdomain>
References: <20041117111336.608409ef.akpm@osdl.org>
	<Pine.LNX.4.44.0411171938210.1809-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> On Wed, 17 Nov 2004, Andrew Morton wrote:
> > Andi Kleen <ak@suse.de> wrote:
> > > On Tue, Nov 16, 2004 at 10:54:09PM -0500, Chuck Ebbert wrote:
> > > > On Wed, 17 Nov 2004 at 02:00:20 +0100, Andi Kleen wrote:
> > > > > On Mon, Nov 15, 2004 at 11:15:51PM -0500, Chuck Ebbert wrote:
> > > > > > Andrea posted this one-liner a while ago as part of a larger patch.  He said
> > > > > > it fixed return of the wrong policy in some conditions.  Was this a valid fix?
> > > > >
> > > > > Yes it was.
> > > > 
> > > >   At least it wasn't dropped -- it's in -mm as part of
> > > > fix-for-mpol-mm-corruption-on-tmpfs, though it's unrelated to tmpfs.
> > > > (That patch contains three separate changes...)
> > > > 
> > > >   Should just this part, which changes '<' to '<=', be pushed upstream?
> > > 
> > > Yes. I'm sure Andrea will take care of that himself. 
> > 
> > That fix is contained within fix-for-mpol-mm-corruption-on-tmpfs.patch
> > anyway, isn't it?
> 
> Yes; and Chuck is right that it's three patches not one.

Always a source of hassles, that.

> I think at the least you should split it by file into mm/shmem.c
> and mm/mempolicy.c parts, they're entirely independent.
> 
> I've seen Andi's ack on the '<=' fix,
> I've not seen his ack on the mempolicy optimizations.

Sigh.  OK, I'll split the patch into three and will feed the `<=' fix and
the symlink fix into 2.6.10.  The mempolicy optimisation can await 2.6.11.

