Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317017AbSG1SI3>; Sun, 28 Jul 2002 14:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317024AbSG1SI3>; Sun, 28 Jul 2002 14:08:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50519 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S317017AbSG1SI2>; Sun, 28 Jul 2002 14:08:28 -0400
To: Anton Altaparmakov <aia21@cantab.net>
Cc: torvalds@transmeta.com (Linus Torvalds),
       linux-kernel@vger.kernel.org (Linux Kernel)
Subject: Re: [BK PATCH 2.5] fs/binfmt_aout.c: Use PAGE_ALIGN_LL() on 64-bit values
References: <E17YRsD-0006Hw-00@storm.christs.cam.ac.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Jul 2002 11:59:42 -0600
In-Reply-To: <E17YRsD-0006Hw-00@storm.christs.cam.ac.uk>
Message-ID: <m1wurfhgxd.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cantab.net> writes:

> Linus,
> 
> Following from previous patch which introduced PAGE_ALIGN_LL, this
> one fixes a bug in fs/binfmt_aout.c which was using PAGE_ALIGN
> on 64-bit values... It now uses PAGE_ALIGN_LL.
> 
> Patch together with the other two patches available from:
> 
> 	bk pull http://linux-ntfs.bkbits.net/linux-2.5-pm

Huh?

All virtual addresses on 32bit platforms are 32bit, as are all lengths
of address space.  

Unless you are running a 32bit kernel with a 64bit user space,
which is simply crazy, unless you are stuck doing it that way.

Eric
