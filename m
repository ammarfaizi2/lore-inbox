Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135635AbRDXRCJ>; Tue, 24 Apr 2001 13:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135576AbRDXRBt>; Tue, 24 Apr 2001 13:01:49 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:37271 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S135549AbRDXRBr>; Tue, 24 Apr 2001 13:01:47 -0400
Date: Tue, 24 Apr 2001 13:01:40 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: "Tom Brusehaver (N-Sysdyne Corporation)" <Thomas.Brusehaver@lmco.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: shm_open doesn't work (fix maybe).
Message-ID: <20010424130140.P9725@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <3AE5ADDC.A7AA6F51@lmco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AE5ADDC.A7AA6F51@lmco.com>; from Thomas.Brusehaver@lmco.com on Tue, Apr 24, 2001 at 11:46:20AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 11:46:20AM -0500, Tom Brusehaver (N-Sysdyne Corporation) wrote:
> 
> I have been chasing all around trying to find out why
> shm_open always returns ENOSYS. It is implemented
> in glibc-2.2.2, and seems the 2.4.3 kernel knows about
> shmfs.
> 
> It seems the file linux/mm/shmem.c has:
>     #define SHMEM_MAGIC 0x01021994
> 
> And the glibc-2.2.2/sysdeps/unix/sysv/linux/linux_fsinfo.h has:
>     #define SHMFS_SUPER_MAGIC 0x02011994
> 
> Well, which is correct?

Update your glibc, 2.2.3pre* matches 2.4.x kernel:

2001-03-03  Ulrich Drepper  <drepper@redhat.com>

	* sysdeps/unix/sysv/linux/linux_fsinfo.h (SHMFS_SUPER_MAGIC):
	Update for real 2.4 kernels.

	Jakub
