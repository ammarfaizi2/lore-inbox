Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbTEMPqa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbTEMPqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:46:30 -0400
Received: from crack.them.org ([146.82.138.56]:9362 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id S261577AbTEMPq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:46:29 -0400
Date: Tue, 13 May 2003 11:59:01 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
Message-ID: <20030513155901.GA26116@nevyn.them.org>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20030512155417.67a9fdec.akpm@digeo.com> <20030512155511.21fb1652.akpm@digeo.com> <shswugvjcy9.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shswugvjcy9.fsf@charged.uio.no>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 01:36:14PM +0200, Trond Myklebust wrote:
> >>>>> " " == Andrew Morton <akpm@digeo.com> writes:
> 
>      > - NFS client gets an OOM deadlock.
>      > - Some fixes exist in -mm.  Seem to mostly work.
>      > - NFS client runs very slowly consuming 100% CPU under heavy
>      >   writeout.
>      > - Unsubtle fix exists in -mm.  (Looks like it's fixed anyway).
> 
> <snip>
> 
>      > - davej: NFS seems to have a really bad time for some people.  (Including
>      >   myself on one testbox).  The common factor seems to be a high
>      >   spec client torturing an underpowered NFS server with lots of
>      >   IO.  (fsx/fsstress etc show this up).  Lots of "NFS server
>      >   cheating" messages get dumped, and a whole lot of bogus
>      >   packets start appearing.  They look severely corrupted, (they
>      >   even crashed ethereal once 8-)
> 
> Could people please test these items out again using the latest
> Bitkeeper release? I believe I've addressed all these issues with the
> patches that have gone to Linus in the last 2-3 weeks.

Well, using BK as of Friday last week I'm still having a complete
disaster of NFS support.  Copying a 13MB file within an NFS-mounted
directory usually yields an I/O error, creating that same file does too
(it's a final link, so I don't know offhand if reading the objects or
writing the binary is falling over).  Server is rather old now,
in-kernel NFSd from 2.4.19-pre10-ac2, but it works just fine on 2.4
clients.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
