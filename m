Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267056AbRGMMMi>; Fri, 13 Jul 2001 08:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267057AbRGMMM2>; Fri, 13 Jul 2001 08:12:28 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:38184 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267056AbRGMMMU>; Fri, 13 Jul 2001 08:12:20 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200107131212.f6DCC0v16274@devserv.devel.redhat.com>
Subject: Re: [NFS] [PATCH] Bug in NFS - should umask be allowed to set umask???
To: neilb@cse.unsw.edu.au (Neil Brown)
Date: Fri, 13 Jul 2001 08:12:00 -0400 (EDT)
Cc: abramo@alsa-project.org (Abramo Bagnara),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Linux Kernel),
        nfs-devel@linux.kernel.org, nfs@lists.sourceforge.net
In-Reply-To: <15182.58236.133661.221154@notabene.cse.unsw.edu.au> from "Neil Brown" at Jul 13, 2001 10:03:08 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1/ Claim that redhat is broken. Leave them to fix SysVinit.
> 2/ Have nfsd over-write the umask setting that /sbin/init imposed.
>    This is effectively what your patch does.
> 3/ Decide that it is inappropriate for nfsd to share the current->fs
>    fs_struct with init.  Unfortunately this means changing or
>    replacing daemonize().

#3 seems right. Of course its not clear whose fs struct should be shared
