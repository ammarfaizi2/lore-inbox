Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280798AbRKOJi2>; Thu, 15 Nov 2001 04:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280799AbRKOJiT>; Thu, 15 Nov 2001 04:38:19 -0500
Received: from ns.suse.de ([213.95.15.193]:8975 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S280798AbRKOJiG>;
	Thu, 15 Nov 2001 04:38:06 -0500
Mail-Copies-To: never
To: "Alex Adriaanse" <alex_a@caltech.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: LFS stopped working
In-Reply-To: <JIEIIHMANOCFHDAAHBHOOEOLCMAA.alex_a@caltech.edu>
From: Andreas Jaeger <aj@suse.de>
Date: Thu, 15 Nov 2001 10:38:05 +0100
In-Reply-To: <JIEIIHMANOCFHDAAHBHOOEOLCMAA.alex_a@caltech.edu> ("Alex
 Adriaanse"'s message of "Wed, 14 Nov 2001 14:05:21 -0800")
Message-ID: <hoofm45q82.fsf@gee.suse.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alex Adriaanse" <alex_a@caltech.edu> writes:

> Hey,
>
> I've been running 2.4.14 for a few days now.  I needed LFS support, so I
> recompiled glibc 2.1.3 with the new 2.4 headers, and after that I could
> create large files (e.g. using dd if=/dev/zero of=test bs=1M count=0
> seek=3000) just fine.
>
> However, as of yesterday, I couldn't create files bigger than 2GB anymore.
> I did not change kernels, nor did I mess with libc or anything else (I did
> some Debian package upgrades/installations/recompiles, but I don't think
> they should affect this) - I'm not quite sure what happened.  Now commands
> such as the dd command I mentioned above will die with the message "File
> size limit exceeded", leaving a 2GB file behind.  Rebooting didn't solve
> anything.  My ulimits seem to be fine (file size = unlimited).
>
> The last few lines of the strace on the dd command above shows the
> following:
> open("/dev/zero", O_RDONLY|0x8000)      = 0
> close(1)                                = 0
> open("test", O_RDWR|O_CREAT|0x8000, 0666) = 1
> ftruncate64(0x1, 0xbb800000, 0, 0, 0x1) = 0
> --- SIGXFSZ (File size limit exceeded) ---
> +++ killed by SIGXFSZ +++

ulimit is hit.  I strongly advise to upgrade to glibc 2.2 when using
kernel 2.4,

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
