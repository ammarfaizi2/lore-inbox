Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbRGQJp1>; Tue, 17 Jul 2001 05:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbRGQJpS>; Tue, 17 Jul 2001 05:45:18 -0400
Received: from pat.uio.no ([129.240.130.16]:62950 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S264883AbRGQJpM>;
	Tue, 17 Jul 2001 05:45:12 -0400
To: "Marco d'Itri" <md@Linux.IT>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs_refresh_inode: inode number mismatch
In-Reply-To: <20010717022405.A22156@wonderland.linux.it>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 17 Jul 2001 11:44:57 +0200
In-Reply-To: Marco d'Itri's message of "Tue, 17 Jul 2001 02:24:05 +0200"
Message-ID: <shsd76zsxd2.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Marco d'Itri <md@Linux.IT> writes:

     > Jul 18 00:15:07 newsserver kernel: nfs_refresh_inode: inode
     > number mismatch Jul 18 00:15:07 newsserver kernel: expected
     > (0x3b30ac75/0x48d5), got (0x3b30ac75/0x8d04)

     > I've got a flood of these messages while talking to a procom
     > NAS this.  Should I worry? Upgrade/patch the kernel? Yell at
     > procom tech support?

Have you applied any extra patches to NFS? I remember one of my
patches (availalble from my WWW-page, but clearly marked experimental)
was generating these messages gratuitously.

If, on the other hand, you're using a clean kernel, I'd look into what
the server is doing. It sounds like it's doing the same thing that the
userland `nfs-server' does: namely to recycle filehandles after a file
gets deleted...

Cheers,
  Trond
