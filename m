Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267882AbRGRN6r>; Wed, 18 Jul 2001 09:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267884AbRGRN6h>; Wed, 18 Jul 2001 09:58:37 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:22278
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S267882AbRGRN62>; Wed, 18 Jul 2001 09:58:28 -0400
Date: Wed, 18 Jul 2001 09:57:56 -0400
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>, Andi Kleen <ak@suse.de>
cc: Craig Soules <soules@happyplace.pdl.cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch
Message-ID: <177360000.995464676@tiny>
In-Reply-To: <3B54B5F9.8484715F@namesys.com>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, July 18, 2001 02:02:33 AM +0400 Hans Reiser <reiser@namesys.com> wrote:

> Andi Kleen wrote:
>> 
>> Craig Soules <soules@happyplace.pdl.cmu.edu> writes:
>> 
>> > Our system does automatic directory compaction through the use of a tree
>> > structure, and so the cookie needs to be invalidated.  Also, any other
>> > file system whicih does immediate directory compaction would require this.
>> 
>> Actually all the file systems who do that on Linux (JFS, XFS, reiserfs)
>> have fixed the issue properly server side, by adding a layer that generates
>> stable cookies. You should too.
>> 

> I take issue with the word "properly".  We have bastardized our FS design to do it.  NFS should not
> be allowed to impose stable cookie maintenance on filesystems, it violates layering.  Simply
> returning the last returned filename is so simple to code, much simpler than what we have to do to
> cope with cookies.  Linux should fix the protocol for NFS, not ask Craig to screw over his FS
> design.  Not that I think that will happen.....
> 

Well, returning the last filename won't do much for filesystems that don't
have any directory indexes, but that's besides the point.  Could nfsv4 be
better than it is?  probably.  Can we change older NFS protocols to have
a linux specific hack that makes them more filesystem (or at least reiserfs)
friendly?  probably.

NFS is what it is, good and bad.  People use it because it fits their setup
better than the others, so the filesystems need to cater to it, exactly
because it has such a large cross platform user base.  Linux specific mods
take away from that cross platform base.

-chris

