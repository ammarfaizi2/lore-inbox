Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130200AbRANDGJ>; Sat, 13 Jan 2001 22:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130207AbRANDF7>; Sat, 13 Jan 2001 22:05:59 -0500
Received: from wg.redhat.de ([193.103.254.4]:11789 "HELO mail.redhat.de")
	by vger.kernel.org with SMTP id <S130200AbRANDFy>;
	Sat, 13 Jan 2001 22:05:54 -0500
Date: Sun, 14 Jan 2001 04:05:50 +0100
From: Karsten Hopp <Karsten.Hopp@redhat.de>
To: Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0-ac9
Message-ID: <20010114040550.A13315@bochum.redhat.de>
In-Reply-To: <01011318404000.18233@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01011318404000.18233@localhost.localdomain>; from elenstev@mesatop.com on Sat, Jan 13, 2001 at 06:40:40PM -0700
X-Warning-1: If you really want to send me spam you can reach me at the address
X-Warning-2: below:
X-Warning-3: uce@ftc.gov - report@fraud.org - spamrecycle@ChooseYourMail.com
X-Warning-4: rbl@mail-abuse.org - rss@mail-abuse.org - dul@mail-abuse.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You need to enable CONFIG_SWAPFS.
Those functions are enclosed by #ifdef CONFIG_SWAPFS and #endif, but 
the references to them aren't.

  Karsten


On Sat, Jan 13, 2001 at 06:40:40PM -0700, Steven Cole wrote:
> I got the following error while building 2.4.0-ac9:
> 
> shmem.c:971: `shmem_readlink' undeclared here (not in a function)
> shmem.c:971: initializer element is not constant
> shmem.c:971: (near initialization for 
> `shmem_symlink_inode_operations.readlink')
> shmem.c:972: `shmem_follow_link' undeclared here (not in a function)
> shmem.c:972: initializer element is not constant
> shmem.c:972: (near initialization for 
> `shmem_symlink_inode_operations.follow_link')
> shmem.c:973: initializer element is not constant
> shmem.c:973: (near initialization for `shmem_symlink_inode_operations')
> shmem.c:973: initializer element is not constant
> shmem.c:973: (near initialization for `shmem_symlink_inode_operations')
> make[2]: *** [shmem.o] Error 1
> 
> It looks like changes were recently made to linux/mm/shmem.c.
> 

--
 Karsten Hopp        | Mail: karsten@redhat.de |
 Red Hat Deutschland |    Karsten.Hopp@sap.com | SAP-AG LinuxLab
 Hauptstaetterstr.58 | Tel: +49-711-96437-0    | Neurottstrasse 16
 D-70178 Stuttgart   | http://www.redhat.de    | 69190 Walldorf
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
