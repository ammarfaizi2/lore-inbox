Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281668AbRLICT7>; Sat, 8 Dec 2001 21:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281647AbRLICTu>; Sat, 8 Dec 2001 21:19:50 -0500
Received: from mons.uio.no ([129.240.130.14]:38910 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S281562AbRLICTl>;
	Sat, 8 Dec 2001 21:19:41 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15378.51767.917907.458718@charged.uio.no>
Date: Sun, 9 Dec 2001 03:19:35 +0100
To: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: PATCH: BSD-style credentials for Linux 2.5.0-pre6...
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  The embryo of an implementation of BSD credentials for Linux
2.5.1-pre5 is now ready in the form of a patch on

  http://www.fys.uio.no/~trondmy/src/bsdcred/linux-2.5.1-pre6_cred.dif

So far there are no changes to the VFS API or even to the SunRPC
code: I'm just concentrating on setting up the basic interface for
sharing credentials between the task_structs and the struct file.

The size of the patch is already pretty nasty & long, but most of it
is just mechanical substitution of current->(|e|u|fs)[ug]id with
appropriate wrappers, and can be ignored. The real meat lies in the 2
new files kernel/cred.c and include/linux/cred.h...

Would interested parties (Al are you listening?) please take a look? 
I'd really appreciate any comments...

Cheers,
   Trond

PS: There is also a file linux-2.4.16-cred.dif in the same directory
that contains the same patch against bog-standard linux-2.4.16...
