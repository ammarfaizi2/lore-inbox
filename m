Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262106AbSJDXhX>; Fri, 4 Oct 2002 19:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262107AbSJDXhX>; Fri, 4 Oct 2002 19:37:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4370 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262106AbSJDXhW>; Fri, 4 Oct 2002 19:37:22 -0400
Date: Fri, 4 Oct 2002 16:44:46 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@digeo.com>
cc: Badari Pulavarty <pbadari@us.ibm.com>, Janet Morgan <janetmor@us.ibm.com>,
       Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: Re: [PATCH] direct-IO API change
In-Reply-To: <3D9E25A7.B3E13D8@digeo.com>
Message-ID: <Pine.LNX.4.44.0210041644050.2526-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Oct 2002, Andrew Morton wrote:
> 
> > Especially since I thought that O_DIRECT on the regular file (or block
> > device) performed about as well as raw does anyway these days? Or is that
> > just one of my LSD-induced flashbacks?
> > 
> 
> Now we're not holding i_sem for O_DIRECT writes to blockdevs,
> I don't think the raw driver offers any advantages at all.  It's
> a compatibility thing to save people from having to add "|O_DIRECT" to
> their source and then typing `ln -s /dev/hda1 /dev/raw/raw0'.

Maybe the raw driver could become a shell that just adds the O_DIRECT? 
Unless it can do something more, of course..

		Linus

