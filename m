Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316135AbSHNXRU>; Wed, 14 Aug 2002 19:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSHNXRU>; Wed, 14 Aug 2002 19:17:20 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:48285 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316135AbSHNXRS>;
	Wed, 14 Aug 2002 19:17:18 -0400
Date: Wed, 14 Aug 2002 19:21:09 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Brian Pawlowski <beepy@netapp.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>, dax@gurulabs.com,
       torvalds@transmeta.com, kmsmith@umich.edu, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: Will NFSv4 be accepted?
In-Reply-To: <200208142234.g7EMYvQ21700@tooting-fe.eng>
Message-ID: <Pine.GSO.4.21.0208141914430.7192-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 Aug 2002, Brian Pawlowski wrote:

> > RPCSEC_GSS is not an argument for NFSv4...
> 
> yes.
> 
> But ACL support over the wire is an argument for V4 - and fine grained
> authorization coupled to strong authentication makes for a flexible 
> security package.

Not really.  With the quality of existing userland (Linux, Solaris, *BSD,
NT, etc.) _anything_ more complex than "I'm the only one who can create
or remove objects here" is a big, gaping hole.  Which makes any theoretical
benefits (if any) of ACL-based schemes moot.  Same (to slightly less extent)
applies to regular files.

In other words, if you need something more complex than usual - you are
screwed on the userland side, regardless of the kernel behaviour.

