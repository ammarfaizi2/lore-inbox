Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264634AbSJ3J3j>; Wed, 30 Oct 2002 04:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264638AbSJ3J3j>; Wed, 30 Oct 2002 04:29:39 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:14611 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S264634AbSJ3J3g>; Wed, 30 Oct 2002 04:29:36 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15807.43004.24713.813565@laputa.namesys.com>
Date: Wed, 30 Oct 2002 12:35:56 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Hans Reiser <reiser@namesys.com>, torvalds@transmeta.com,
       landley@trommello.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5 merge candidate list, final version.  (End of "crunch time"
 series.)
In-Reply-To: <3DBF9BA5.6000100@pobox.com>
References: <200210280534.16821.landley@trommello.org>
	<15805.27643.403378.829985@laputa.namesys.com>
	<3DBF9600.4060208@namesys.com>
	<3DBF9BA5.6000100@pobox.com>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Meat: Ptarmigan
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
 > Hans Reiser wrote:
 > 
 > > We are going to submit a patch appropriate for inclusion as an 
 > > experimental FS on Halloween.   I hope you will forgive our pushing 
 > > the limit timewise, it is not by choice, but the algorithms we used to 
 > > more than double reiserfs V3 performance were, quite frankly, hard to 
 > > code.
 > 
 > 
 > 
 > Does your merge change the core code at all?  Does it add new syscalls?
 > 

Here is a list of things reiser4 needs from the core:

 (1) export of generic_forget_inode()

 (2) export of page_cache_readahead()

 (3) export of remove_from_page_cache()

 (4) export of fsync_super()

 (5) patch to allow safe sharing of ->journal_info pointer in task_struct
     by several users

(1)-(4) are only necessary to compile reiser4 as module.

(5) is good not only for reiser4. Without it different file systems
using ->journal_info cannot "co-exist peacefully".

No new system calls are introduced (yet).

Nikita.

 > 
