Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbUCXVLf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 16:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbUCXVLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 16:11:35 -0500
Received: from mxsf13.cluster1.charter.net ([209.225.28.213]:61456 "EHLO
	mxsf13.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261933AbUCXVLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 16:11:32 -0500
Date: Wed, 24 Mar 2004 16:02:13 -0500 (EST)
From: ameer armaly <ameer@charter.net>
X-X-Sender: ameer@debian
To: Andy Isaacson <adi@hexapodia.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: missing files in bk tree
In-Reply-To: <20040324200121.GF20793@hexapodia.org>
Message-ID: <Pine.LNX.4.58.0403241601350.7770@debian>
References: <Pine.LNX.4.58.0403232140160.7713@debian> <20040324200121.GF20793@hexapodia.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 24 Mar 2004, Andy Isaacson wrote:

> On Tue, Mar 23, 2004 at 09:41:46PM -0500, ameer armaly wrote:
> > I got the latest kernel tree from linux.bkbits.net, and I try to make
> > config, and it complains about a missing zconf.tab.h.  However, it has
> > decrypted the other sccs files, but for some oodd reason it can't find
> > this particular one.  Suggestions would be appriciated.
>
> The build fails on this file because the kernel makefiles don't have
> complete dependency information.  Make is smart enough to automatically
> check out foo.c and foo.h if you say
>
> foo.o: foo.c foo.h
> 	$(CC) -c foo.c -o foo.o
>
> but in the absence of that information, make cannot deduce it.
>
> The work-around is to simply check out everything before running make:
> % bk -Ur get -S
>
Thanks; It worked.
> -andy
>
