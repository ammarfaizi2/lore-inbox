Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129953AbRCAUog>; Thu, 1 Mar 2001 15:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129948AbRCAUoR>; Thu, 1 Mar 2001 15:44:17 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:11018 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129915AbRCAUoI>; Thu, 1 Mar 2001 15:44:08 -0500
Date: Thu, 1 Mar 2001 21:45:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Matti Aarnio <matti.aarnio@zmailer.org>,
        Ivan Stepnikov <iv@spylog.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel is unstable
Message-ID: <20010301214525.J15051@athlon.random>
In-Reply-To: <20010301153935.G32484@athlon.random> <E14YXh5-0008GQ-00@the-village.bc.nu> <20010301193017.E15051@athlon.random> <15006.40279.407072.321187@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15006.40279.407072.321187@pizda.ninka.net>; from davem@redhat.com on Thu, Mar 01, 2001 at 11:04:55AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2001 at 11:04:55AM -0800, David S. Miller wrote:
> Linus didn't find it to be such a gain, and in fact the one
> place that does gain from such merging (sys_brk()) does the
> merging by hand :-)

somewhere in either kernel or glibc we need to do the merging to avoid
allocating new vmas and to grow the avl, otherwise server environment will be
hurted. We're not going to need this feature to run kde well, or to do
compiles, but people using the 3.5G per-task patch or using a 64bit userspace
becaue they're too strict in 3.5G are certainly going to strictly need this
optimization.

I certainly prefer to do the merging at the kernel layer because it's generic
and it doesn't optimize only malloc users.

Andrea
