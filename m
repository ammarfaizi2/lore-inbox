Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261213AbRE2Ran>; Tue, 29 May 2001 13:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261217AbRE2Rad>; Tue, 29 May 2001 13:30:33 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:20901 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261213AbRE2RaT>;
	Tue, 29 May 2001 13:30:19 -0400
Date: Tue, 29 May 2001 13:30:11 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Gergely Tamas <dice@mfa.kfki.hu>
cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: OOPS with 2.4.5 [kernel BUG at inode.c:486]
In-Reply-To: <Pine.LNX.4.32.0105291858050.4085-100000@falka.mfa.kfki.hu>
Message-ID: <Pine.GSO.4.21.0105291327120.10843-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 May 2001, Gergely Tamas wrote:
 
> Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01c4020, System.map says c0154160.  Ignoring ksyms_base entry
> kernel BUG at inode.c:486!

[snip]

_Lovely_. NFS, apparently on revalidate path, doesn't care to hold on
the unhashed inode until its pages are gone.

Trond?

