Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315734AbSFJSjN>; Mon, 10 Jun 2002 14:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315760AbSFJSjM>; Mon, 10 Jun 2002 14:39:12 -0400
Received: from marc2.theaimsgroup.com ([63.238.77.172]:39948 "EHLO
	marc2.theaimsgroup.com") by vger.kernel.org with ESMTP
	id <S315734AbSFJSjM>; Mon, 10 Jun 2002 14:39:12 -0400
Date: Mon, 10 Jun 2002 14:39:13 -0400
Message-Id: <200206101839.g5AIdDo29997@marc2.theaimsgroup.com>
From: Hank Leininger <linux-kernel@progressive-comp.com>
Reply-To: Hank Leininger <hlein@progressive-comp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: /usr/bin/df reports false size on big NFS shares
X-Shameless-Plug: Check out http://marc.theaimsgroup.com/
X-Warning: This mail posted via a web gateway at marc.theaimsgroup.com
X-Warning: Report any violation of list policy to abuse@progressive-comp.com
X-Posted-By: Hank Leininger <hlein@progressive-comp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-06-10, Samuel Maftoul <maftoul@esrf.fr> wrote:

> On several machines, with kernel 2.4.18 the same mounts reports
> different sizes than with 2.4.4 :

...Or not.

> - maftoul@brick20:~ > uname  -a
> Linux brick20 2.4.4-4GB #6 Thu Jul 26 10:00:30 CEST 2001 i686 unknown
[works]

> maftoul@brick4:~ > uname  -a
> Linux brick4 2.4.18 #3 Thu Apr 4 17:04:20 CEST 2002 i686 unknown
[doesn't work]

> It's all suse 7.2 , first one (2.4.4) is suse 7.2 base kernel, 2.4.18
> is our own (for firewire better firewire support).

Most distributions ship slightly (or heavily) patched kernels.  Above you
can see the 2.4.4 kernel is not stock, it is named '2.4.4-4GB' for one
thing, which most likely means it is tweaked for a 4GB memory system?  That
may be how SuSE shipped kernels for 7.2, idunno.  But the point is, it is
likely that stock 2.4.4 would not work either, it would have the same
problem as 2.4.18.  There's some added bits in  SuSE's release kernel that
make >1TB NFS shares happy.  I'd suggest that you try booting 2.4.4 stock
just to see if it misbehaves the same way 2.4.18 does, and if so, start
trying to figure out what SuSE patch fixes this for you (check SuSE
specific lists, and/or ask their support).  With luck you will find that
either SuSE has a newer 2.4.x kernel with firewire support, or whatever
they've done that fixes NFS can be extracted out and added to a current
stock 2.4.x kernel source.

--
Hank Leininger <hlein@progressive-comp.com> 
  
