Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288949AbSA3ICN>; Wed, 30 Jan 2002 03:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288814AbSA3IBZ>; Wed, 30 Jan 2002 03:01:25 -0500
Received: from mons.uio.no ([129.240.130.14]:51399 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S288956AbSA3IAa>;
	Wed, 30 Jan 2002 03:00:30 -0500
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5: push BKL out of llseek
In-Reply-To: <Pine.GSO.4.21.0201292349260.11157-100000@weyl.math.psu.edu>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
In-Reply-To: <Pine.GSO.4.21.0201292349260.11157-100000@weyl.math.psu.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
Date: 30 Jan 2002 09:00:10 +0100
Message-ID: <shs3d0oi7zp.fsf@charged.uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alexander Viro <viro@math.psu.edu> writes:

     > So I'd prefer to do it in two stages - shift BKL into
     > ->llseek() and then see where it can be dropped/replaced with
     > ->i_sem.

Seconded. There are several filesystems out there for which i_sem does
nothing to protect inode->i_size.

Cheers,
  Trond
