Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266941AbRGTOIL>; Fri, 20 Jul 2001 10:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266945AbRGTOIB>; Fri, 20 Jul 2001 10:08:01 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:9741 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S266941AbRGTOH4>; Fri, 20 Jul 2001 10:07:56 -0400
Date: Fri, 20 Jul 2001 10:07:13 -0400
From: Chris Mason <mason@suse.com>
To: trond.myklebust@fys.uio.no, Hans Reiser <reiser@namesys.com>
cc: Andi Kleen <ak@suse.de>, Craig Soules <soules@happyplace.pdl.cmu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch
Message-ID: <952300000.995638033@tiny>
In-Reply-To: <15191.61681.847920.761502@charged.uio.no>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Friday, July 20, 2001 10:50:57 AM +0200 Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

>>>>>> " " == Hans Reiser <reiser@namesys.com> writes:
> 
>      > The current code does rely on hidden knowledge of the filesytem
>      > on the server, and refuses to operate with any FS that does not
>      > describe a position in a directory as an offset or hash that
>      > fits into 32 or 64 bits.
> 
> I'm not saying that ReiserFS is wrong to question the correctness of
> this. I'm just saying that NFSv2 and v3 are fixed protocols, and that
> it's too late to do anything about them. I read Chris mail as a
> suggestion of creating yet another NQNFS, and this would IMHO be a
> mistake. Better to concentrate on NFSv4 which is meant to be
> extendible.

Ah, then I was unclear...I think that while we certainly could
make linux (or reiserfs) specific changes to NFSvOld, it would be
a really bad idea.  In my mind, the biggest strength behind NFS
is its cross platform support, and maintaining some extension
would only be slightly more fun than daily visits to the dentist ;-)

I also think it is easy to call NFSv4 poorly designed, but much
harder to design it to exploit the strengths of every FS on every
unix flavor.  Shrug, there are tradeoffs everywhere.  

I don't plan on supporting NFSv4 because it is the best network 
filesystem ever made, but because it is in our best interest to 
be compatible with those kinds of industry standards.

-chris

