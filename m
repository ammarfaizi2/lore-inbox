Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267475AbRGQWDr>; Tue, 17 Jul 2001 18:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267469AbRGQWDh>; Tue, 17 Jul 2001 18:03:37 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:18183 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S267457AbRGQWDc>; Tue, 17 Jul 2001 18:03:32 -0400
Message-ID: <3B54B5F9.8484715F@namesys.com>
Date: Wed, 18 Jul 2001 02:02:33 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Craig Soules <soules@happyplace.pdl.cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch
In-Reply-To: <Pine.LNX.3.96L.1010709131315.16113O-200000@happyplace.pdl.cmu.edu.suse.lists.linux.kernel> <oupbsmueyv8.fsf@pigdrop.muc.suse.de>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> Craig Soules <soules@happyplace.pdl.cmu.edu> writes:
> 
> > Our system does automatic directory compaction through the use of a tree
> > structure, and so the cookie needs to be invalidated.  Also, any other
> > file system whicih does immediate directory compaction would require this.
> 
> Actually all the file systems who do that on Linux (JFS, XFS, reiserfs)
> have fixed the issue properly server side, by adding a layer that generates
> stable cookies. You should too.
> 
> -Andi
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I take issue with the word "properly".  We have bastardized our FS design to do it.  NFS should not
be allowed to impose stable cookie maintenance on filesystems, it violates layering.  Simply
returning the last returned filename is so simple to code, much simpler than what we have to do to
cope with cookies.  Linux should fix the protocol for NFS, not ask Craig to screw over his FS
design.  Not that I think that will happen.....

Hans
