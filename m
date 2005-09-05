Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbVIETzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbVIETzV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 15:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbVIETzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 15:55:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19410 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750945AbVIETzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 15:55:20 -0400
Date: Mon, 5 Sep 2005 12:53:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: teigland@redhat.com, Joel.Becker@oracle.com, ak@suse.de,
       linux-cluster@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-Id: <20050905125309.4b657b08.akpm@osdl.org>
In-Reply-To: <1125922894.8714.14.camel@localhost.localdomain>
References: <20050901104620.GA22482@redhat.com>
	<20050903183241.1acca6c9.akpm@osdl.org>
	<20050904030640.GL8684@ca-server1.us.oracle.com>
	<200509040022.37102.phillips@istop.com>
	<20050903214653.1b8a8cb7.akpm@osdl.org>
	<20050904045821.GT8684@ca-server1.us.oracle.com>
	<20050903224140.0442fac4.akpm@osdl.org>
	<20050905043033.GB11337@redhat.com>
	<20050905015408.21455e56.akpm@osdl.org>
	<20050905092433.GE17607@redhat.com>
	<20050905021948.6241f1e0.akpm@osdl.org>
	<1125922894.8714.14.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Llu, 2005-09-05 at 02:19 -0700, Andrew Morton wrote:
>  > >   create_lockspace()
>  > >   release_lockspace()
>  > >   lock()
>  > >   unlock()
>  > 
>  > Neat.  I'd be inclined to make them syscalls then.  I don't suppose anyone
>  > is likely to object if we reserve those slots.
> 
>  If the locks are not file descriptors then answer the following:
> 
>  - How are they ref counted
>  - What are the cleanup semantics
>  - How do I pass a lock between processes (AF_UNIX sockets wont work now)
>  - How do I poll on a lock coming free. 
>  - What are the semantics of lock ownership
>  - What rules apply for inheritance
>  - How do I access a lock across threads.
>  - What is the permission model. 
>  - How do I attach audit to it
>  - How do I write SELinux rules for it
>  - How do I use mount to make namespaces appear in multiple vservers
> 
>  and thats for starters...

Return an fd from create_lockspace().
