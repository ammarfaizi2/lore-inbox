Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316187AbSHBRx7>; Fri, 2 Aug 2002 13:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315919AbSHBRx7>; Fri, 2 Aug 2002 13:53:59 -0400
Received: from mons.uio.no ([129.240.130.14]:13798 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S316088AbSHBRx6>;
	Fri, 2 Aug 2002 13:53:58 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       David Woodhouse <dwmw2@infradead.org>,
       David Howells <dhowells@redhat.com>, <alan@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: manipulating sigmask from filesystems and drivers
References: <Pine.LNX.4.44.0208021023040.914-100000@home.transmeta.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 02 Aug 2002 19:57:10 +0200
In-Reply-To: <Pine.LNX.4.44.0208021023040.914-100000@home.transmeta.com>
Message-ID: <shsr8hhqh3d.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Linus Torvalds <torvalds@transmeta.com> writes:

     >  "Which is what we want in generic_file_read() (and _probably_
     >   generic_file_write() as well, but that's slightly more
     >   debatable)"

A frequent cause of complaints with the NFS client 'intr' mount option
is that grabbing the inode semaphore too is uninterruptible, and hence
even a lookup() can hang.
Would you therefore be planning on making down() interruptible by
SIGKILL?

Cheers,
   Trond
