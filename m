Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbSJ3KJs>; Wed, 30 Oct 2002 05:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264647AbSJ3KJr>; Wed, 30 Oct 2002 05:09:47 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:20487 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S261337AbSJ3KJG>; Wed, 30 Oct 2002 05:09:06 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15807.45377.386626.921875@laputa.namesys.com>
Date: Wed, 30 Oct 2002 13:15:29 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Andrew Morton <akpm@digeo.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Hans Reiser <reiser@namesys.com>,
       torvalds@transmeta.com, landley@trommello.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5 merge candidate list, final version.  (End of "crunch time"series.)
In-Reply-To: <3DBFA7E3.345690B2@digeo.com>
References: <200210280534.16821.landley@trommello.org>
	<15805.27643.403378.829985@laputa.namesys.com>
	<3DBF9600.4060208@namesys.com>
	<3DBF9BA5.6000100@pobox.com>
	<3DBFA7E3.345690B2@digeo.com>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-NSA-Fodder: Legion of Doom cypherpunk uranium cryptographic Mena Watergate
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Jeff Garzik wrote:
 > > 
 > > Hans Reiser wrote:
 > > 
 > > > We are going to submit a patch appropriate for inclusion as an
 > > > experimental FS on Halloween.   I hope you will forgive our pushing
 > > > the limit timewise, it is not by choice, but the algorithms we used to
 > > > more than double reiserfs V3 performance were, quite frankly, hard to
 > > > code.
 > > 
 > > Does your merge change the core code at all?  Does it add new syscalls?
 > > 
 > 
 > Their changes are tiny, and sensible.  See
 > http://www.namesys.com/snapshots/2002.10.29/
 > 
 > But I'd like to ask about the status of reiser3 support.
 > 
 > Chris had patches *ages* ago to convert it to use direct-to-BIO for
 > reads, and writes should be done as well.  reiserfs3 is still using
 > buffer-head-based IO for bulk reads and writes.  That's a 25-30% hit
 > in CPU cost, and all the old ZONE_NORMAL-full-of-buffer_heads
 > problems.

Are you talking about buffer_heads_over_limit magic inside vmscan.c? Is
it to avoid deadlock with buffer_head allocation in ->vm_writeback?

 > 
 > Any plans to get that work finished off?

Chris had done great work indeed (plus data logging, plus quotas, plus
ACLs by Jeff Mahoney, etc). Unfortunately we were too busy with reiser4
here lately. Hopefully, a lot of stuff will be merged into reiserfs3.x
after Halloween.

Nikita.
