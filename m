Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUCVAZM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 19:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbUCVAZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 19:25:12 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:26499 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261567AbUCVAZD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 19:25:03 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 21 Mar 2004 16:25:31 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
In-Reply-To: <m1y8ptu42m.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.44.0403211623400.12699-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Mar 2004, Eric W. Biederman wrote:

> Jörn Engel <joern@wohnheim.fh-wedel.de> writes:
> 
> > On Sun, 21 March 2004 09:59:39 -0800, Davide Libenzi wrote:
> > > 
> > > When I did that, fumes of an in-kernel implementation invaded my head for 
> > > a little while. Then you start thinking that you have to teach apps of new 
> > > open(2) semantics, you have to bloat kernel code a little bit and you have 
> > > to deal with a new set of errors cases that open(2) is not expected to 
> > > deal with. A fully userspace implementation did fit my needs at that time, 
> > > even if the LD_PRELOAD trick might break if weak aliases setup for open 
> > > functions change inside glibc.
> > 
> > 209 fairly simple lines definitely have more appear than a full
> > in-kernel implementation with many new corner-cases, yes.  But it
> > looks as if you ignore the -ENOSPC case, so you cheated a little. ;)
> > 
> > No matter how you try, there is no way around an additional return
> > code for open(), so we have to break compatibility anyway.  The good
> > news is that a) people not using this feature won't notice and b) all
> > programs I tried so far can deal with the problem.  Vim even has a
> > decent error message - as if my patch was anticipated already.
> 
> Actually there is...  You don't do the copy until an actual write occurs.
> Some files are opened read/write when there is simply the chance they might
> be written to so delaying the copy is generally a win.

What about open+mmap?
	


- Davide


