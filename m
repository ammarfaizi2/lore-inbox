Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277024AbRJKXJX>; Thu, 11 Oct 2001 19:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277039AbRJKXJO>; Thu, 11 Oct 2001 19:09:14 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:36213 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S277024AbRJKXJF>; Thu, 11 Oct 2001 19:09:05 -0400
Date: Fri, 12 Oct 2001 01:08:46 +0200
From: Christian Ullrich <chris@chrullrich.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Vincent Sweeney <v.sweeney@dexterus.com>, arvest@orphansonfire.com,
        linux-kernel@vger.kernel.org
Subject: Re: Partitioning problems in 2.4.11
Message-ID: <20011012010846.A982@christian.chrullrich.de>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Vincent Sweeney <v.sweeney@dexterus.com>, arvest@orphansonfire.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0110111538200.24742-100000@weyl.math.psu.edu> <Pine.GSO.4.21.0110111835360.24742-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.GSO.4.21.0110111835360.24742-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Oct 11, 2001 at 06:42:06PM -0400
X-Current-Uptime: 0 d, 00:01:47 h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alexander Viro wrote on Thursday, 2001-10-11:

> 	*Damn*.  grok_partitions() doesn't set the size of entire device
> until it's done with check_partition().  Which means max_blocks() behaving
> in all sorts of interesting ways, depending on phase of moon, etc.
> 
> 	Could you check if the following helps?

Yeah, that one did it.

dmesg (only the interesting parts):

 hdb:[63 10000305]
 hdb1[10000368 68063184]
 hdb2 <[10000431 20972889]
 hdb5[48063519 30000033]
 hdb6 >[78063552 1999872]
 hdb3

reiserfs: checking transaction log (device 03:46) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
(this time, no errors to follow)


-- 
Christian Ullrich		     Registrierter Linux-User #125183

"Sie können nach R'ed'mond fliegen -- aber Sie werden sterben"
