Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288040AbSAHNtO>; Tue, 8 Jan 2002 08:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288038AbSAHNtE>; Tue, 8 Jan 2002 08:49:04 -0500
Received: from cti06.citenet.net ([206.123.38.70]:34573 "EHLO
	cti06.citenet.net") by vger.kernel.org with ESMTP
	id <S288033AbSAHNs4>; Tue, 8 Jan 2002 08:48:56 -0500
From: Jacques Gelinas <jack@solucorp.qc.ca>
Date: Tue, 8 Jan 2002 08:42:35 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Whizzy New Feature: Paged segmented memory
X-mailer: tlmpmail 0.1
Message-ID: <20020108084235.628e035081b2@remtk.solucorp.qc.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2002 12:22:25 -0500, jtv wrote
> On Tue, Jan 08, 2002 at 02:17:14AM -0500, Anthony DeRobertis wrote:
> >
> > A nice thing about two stacks is that it can be a completely
> > userspace thing. No need to involve the kernel at all; just gcc
> > and friends.
>
> Doesn't it have ABI implications as well?

Yes, it might make the whole thing binary incompatible (so we could
have a new glibc major release :-) ) Not sure.

> If so, why not go all the way and have stacks grow upwards?  :-)

This won't help. It will change the attack pattern though (so it may help
a bit). If the stack grow upward, then the data from the caller, passed to the
callee will be used to create the overflow. Taking control this way is still
possible.

And the stack grow direction is controlled by the CPU stack operation and
we can't change it.

---------------------------------------------------------
Jacques Gelinas <jack@solucorp.qc.ca>
vserver: run general purpose virtual servers on one box, full speed!
http://www.solucorp.qc.ca/miscprj/s_context.hc
