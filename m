Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263421AbRFNRVh>; Thu, 14 Jun 2001 13:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263423AbRFNRV1>; Thu, 14 Jun 2001 13:21:27 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:15920 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263421AbRFNRVQ>; Thu, 14 Jun 2001 13:21:16 -0400
Date: Thu, 14 Jun 2001 19:21:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Richard Henderson <rth@redhat.com>
Subject: Re: unregistered changes to the user<->kernel API
Message-ID: <20010614192122.C30567@athlon.random>
In-Reply-To: <20010614191219.A30567@athlon.random> <20010614191634.B30567@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010614191634.B30567@athlon.random>; from andrea@suse.de on Thu, Jun 14, 2001 at 07:16:34PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2001 at 07:16:34PM +0200, Andrea Arcangeli wrote:
> I just got the email from Richard that he prefers to break O_NOFOLLOW

Richard are you sure we can break O_NOFOLLOW and still expect the machine to
boot?

./elf/cache.c:  fd = open (temp_name, O_CREAT|O_WRONLY|O_TRUNC|O_NOFOLLOW,
./elf/dl-profile.c:#ifdef O_NOFOLLOW
./elf/dl-profile.c:# define EXTRA_FLAGS | O_NOFOLLOW
./elf/rtld.c:#ifdef O_NOFOLLOW
./elf/rtld.c:      const int flags = O_WRONLY | O_APPEND | O_CREAT | O_NOFOLLOW;
./include/asm/fcntl.h:#define O_NOFOLLOW        0400000 /* don't follow links */
./sysdeps/generic/check_fds.c:     the O_NOFOLLOW flag for open() but only on some system.  */
./sysdeps/generic/check_fds.c:#ifndef O_NOFOLLOW
./sysdeps/generic/check_fds.c:# define O_NOFOLLOW       0
./sysdeps/generic/check_fds.c:  check_one_fd (STDIN_FILENO, O_RDONLY | O_NOFOLLOW);
./sysdeps/generic/check_fds.c:  check_one_fd (STDOUT_FILENO, O_RDWR | O_NOFOLLOW);
./sysdeps/generic/check_fds.c:  check_one_fd (STDERR_FILENO, O_RDWR | O_NOFOLLOW);
./sysdeps/unix/sysv/linux/alpha/bits/fcntl.h:# define O_NOFOLLOW        0200000 /* Do not follow links.  */
./sysdeps/unix/sysv/linux/shm_open.c:  fd = open (fname, oflag | O_NOFOLLOW, mode);

Andrea
