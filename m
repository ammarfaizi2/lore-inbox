Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318272AbSIOVvi>; Sun, 15 Sep 2002 17:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318274AbSIOVvi>; Sun, 15 Sep 2002 17:51:38 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:30674 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S318272AbSIOVvh>; Sun, 15 Sep 2002 17:51:37 -0400
Date: Sun, 15 Sep 2002 17:56:32 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Matthew Wilcox <willy@debian.org>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: problem with "Use CLONE_KERNEL for the common kernel thread
 flags"?
In-Reply-To: <20020915225419.F10583@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0209151755490.28974-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 15 Sep 2002, Matthew Wilcox wrote:

> -#define CLONE_SIGNAL   (CLONE_SIGHAND | CLONE_THREAD)
> +#define CLONE_KERNEL   (CLONE_FS | CLONE_FILES | CLONE_SIGHAND)
> -       kernel_thread(init, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
> +       kernel_thread(init, NULL, CLONE_KERNEL);
> 
> init used to be spawned with CLONE_THREAD and no longer is.  Was this
> intentional? [...]

i think Linus combined a cleanup with the fix i sent earlier today, so
this does look intentional.

	Ingo

