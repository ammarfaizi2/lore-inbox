Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbSKGPhy>; Thu, 7 Nov 2002 10:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261291AbSKGPhx>; Thu, 7 Nov 2002 10:37:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45069 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261290AbSKGPhx>; Thu, 7 Nov 2002 10:37:53 -0500
Date: Thu, 7 Nov 2002 07:44:51 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: [lkcd-devel] Re: What's left over.
In-Reply-To: <m14ratepbf.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.44.0211070731200.5567-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 7 Nov 2002, Eric W. Biederman wrote:
> 
> There are currently 2 cases that it would be nice to have work.
> 1) Load a new kernel and immediately execute it.
> 2) Load a new kernel and execute it on panic.

I really don't think (1) is _ever_ a valid thing to do.

The fact is, loading a new kernel wants filesystems and a fully working 
system. While executing it wants the filesystems quiescent.

> panic does not call sys_reboot it rolls that functionality by hand.

Forget about panic for now. It's a design issue - it should be possible to 
work, but somebody else can do it if the infrastructure is done right.

> In a unified design I can buffer the image in the anonymous pages of a
> user space process just as well as I can in locked down kernel memory.

And in a unified design, I won't apply the patches. It's that simple.

		Linus

