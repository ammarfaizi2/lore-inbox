Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293251AbSCJVOG>; Sun, 10 Mar 2002 16:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293244AbSCJVN4>; Sun, 10 Mar 2002 16:13:56 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:56560 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S293243AbSCJVNl>;
	Sun, 10 Mar 2002 16:13:41 -0500
Date: Sun, 10 Mar 2002 16:13:32 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Paul P Komkoff Jr <i@stingr.net>
cc: linux-kernel@vger.kernel.org, Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: Bug in do_mounts.c/namespace.c/devfs ?
In-Reply-To: <20020310193152.GJ28744@stingr.net>
Message-ID: <Pine.GSO.4.21.0203101612100.7778-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Mar 2002, Paul P Komkoff Jr wrote:

> This is clearly reproducible here.
> Let's have 2.4.19-pre2-ac{2,3,maybe 4}.
> Let compile in devfs support but dont enable mount on boot etc.
> 
> After boot we will have in /proc/mounts the following line
> devfs /dev devfs
> (other mounts)

>                 sys_umount(".", 0);

Good catch - it should be
		  sys_umount(".", MNT_DETACH);

