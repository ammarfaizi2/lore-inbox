Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265851AbUBPUQV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 15:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265872AbUBPUQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 15:16:21 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:38326 "EHLO
	mailout.schmorp.de") by vger.kernel.org with ESMTP id S265851AbUBPUQT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 15:16:19 -0500
Date: Mon, 16 Feb 2004 21:16:10 +0100
From: Marc Lehmann <pcg@schmorp.de>
To: John Bradford <john@grabjohn.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
Message-ID: <20040216201610.GC17015@schmorp.de>
Mail-Followup-To: John Bradford <john@grabjohn.com>,
	Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402150006.23177.robin.rosenberg.lists@dewire.com> <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk> <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <4031197C.1040909@pobox.com> <200402161948.i1GJmJi5000299@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402161948.i1GJmJi5000299@81-2-122-30.bradfords.org.uk>
X-Operating-System: Linux version 2.4.24 (root@cerebro) (gcc version 2.95.4 20011002 (Debian prerelease)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 07:48:19PM +0000, John Bradford <john@grabjohn.com> wrote:
> Quote from Jeff Garzik <jgarzik@pobox.com>:
> None of this is a real problem, if everything is set up correctly and
> bug free.  Unfortunately the Just Works thing falls apart in the,
> (frequent), instances that it's not :-(.
      
And this is the whole point.

BTW, to people trying to explain some properties of UTF-8 to me. I don't
think ad-hominem attacks like assuming that I don't understand UTF-8
(without any indication that this is so) are useful.

The point here is that the kernel does, in a very narrow interpretation,
not support the use of UTF-8, because proper support of UTF-8 means that
no illegal byte sequences will be produced.

Of course, I can feed the kernel UTF-8, and if everybody does that, it
will generally work quite fine. However, Windows surely works fine if
every program only feeds allowed values into system calls. And even unix
dialects without memory protection work, as long as everybody plays
fair.

The point is, however, that this is highly undesirable, and it would be
nice to have a kernel that would (optionally) fully support a UTF-8
environment in where applications can feed UTF-8 and _expect_ UTF-8 in
return, which _is_ a security issue.

It's very desirable to have a kernel that actively supports this. IT is
clearly not _required_, of course. But then again, process abstraction
is also not required...

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
