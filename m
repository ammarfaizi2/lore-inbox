Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270037AbRHQJUd>; Fri, 17 Aug 2001 05:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270036AbRHQJUX>; Fri, 17 Aug 2001 05:20:23 -0400
Received: from pat.uio.no ([129.240.130.16]:35492 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S270031AbRHQJUO>;
	Fri, 17 Aug 2001 05:20:14 -0400
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.9: atomic_dec_and_lock sometimes used while not defined
In-Reply-To: <200108161821.LAA02805@adam.yggdrasil.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 17 Aug 2001 11:20:18 +0200
In-Reply-To: "Adam J. Richter"'s message of "Thu, 16 Aug 2001 11:21:45 -0700"
Message-ID: <shs8zgjdovh.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Adam J Richter <adam@yggdrasil.com> writes:

     > 	If I try to build a kernel that can do SMP and run on a 386,
     > the linux-2.4.9 NFS client gets compiled with an undefined
     > reference to atomic_dec_and_lock().

Why aren't you seeing the same error in linux/fs/inode.c? That also
references atomic_dec_and_lock when compiling 386 SMP...

     > 	However, I'm really not clear enough on the semantics of
     > atomic_dec_and_lock vs. atomic_dec_and_test to know whether
     > this is safe.

     > 	Also, it looks like arch/sparc64/sparc64_ksyms.c references
     > atomic_dec_and_test without it every being defined on any
     > architecture other than x86, so I am suspicious of a partially
     > applied patch here.

See linux/arch/sparc64/lib/dec_and_lock.S. atomic_dec_and_lock should
indeed be defined on a sparc64.

Cheers,
   Trond
