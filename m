Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261997AbSJDXQL>; Fri, 4 Oct 2002 19:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262003AbSJDXQL>; Fri, 4 Oct 2002 19:16:11 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13584 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261997AbSJDXPu>; Fri, 4 Oct 2002 19:15:50 -0400
Date: Fri, 4 Oct 2002 16:23:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@digeo.com>
cc: Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: Re: [PATCH] direct-IO API change
In-Reply-To: <3D9E1847.F6DDA3AE@digeo.com>
Message-ID: <Pine.LNX.4.44.0210041621170.2526-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Oct 2002, Andrew Morton wrote:
> 
> Because the file handle which we have is for /dev/raw/raw0,
> not for /dev/hda1.
> 
> The raw driver binds to major/minor, not a file*.  I considered
> changing that (change userspace to pass the open fd).  But didn't.

Ok. I'd really rather have a cleaner internal API and break the raw driver 
for a while, than have a silly API just because the raw driver uses it.

Especially since I thought that O_DIRECT on the regular file (or block
device) performed about as well as raw does anyway these days? Or is that
just one of my LSD-induced flashbacks?

		Linus

