Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277094AbRKFLLe>; Tue, 6 Nov 2001 06:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278968AbRKFLLZ>; Tue, 6 Nov 2001 06:11:25 -0500
Received: from rafiu.psi-domain.co.uk ([212.87.84.199]:58374 "HELO
	rafiu.psi-domain.co.uk") by vger.kernel.org with SMTP
	id <S277094AbRKFLLQ>; Tue, 6 Nov 2001 06:11:16 -0500
Date: Tue, 6 Nov 2001 11:12:30 +0000
From: James Chivers <chiversj@psi-domain.co.uk>
To: linux-kernel@vger.kernel.org
Subject: kernel: RPC: garbage, exit EIO
Message-ID: <20011106111230.C1294@unimatrix001>
Reply-To: chiversj@psi-domain.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I have recently deployed a Linux server running SuSE 7.2, with kernel
2.4.7-64GB-SMP, and are getting a string of entries in /var/log/messages
like -

Nov  4 20:16:49 myserver kernel: RPC: garbage, exit EIO
Nov  4 20:17:20 myserver last message repeated 251 times
Nov  4 20:18:21 myserver last message repeated 556 times
Nov  4 20:19:22 myserver last message repeated 442 times
Nov  4 20:20:23 myserver last message repeated 650 times
Nov  4 20:21:24 myserver last message repeated 598 times
Nov  4 20:22:25 myserver last message repeated 394 times
Nov  4 20:23:26 myserver last message repeated 724 times
Nov  4 20:24:27 myserver last message repeated 702 times
Nov  4 20:25:28 myserver last message repeated 380 times
Nov  4 20:25:31 myserver last message repeated 34 times

The box is configured as an nfs client, but not server.

The nfs servers to which it mounts have no /var/log/messages entries like
Nov  4 20:00:00 nfs_server: bad getargs
 - as was previously suggested on a thread many moons ago.

I'm having trouble re-producing the errors at will, just seem to be random.

I am running a continuous kernel compilation script on the box -
http://sdb.suse.de/en/sdb/html/hmeyer_memtest-sig11.html
 - and when the above errors do strike, I get (compilation) log file entry
errors like -

make: execvp: /bin/pwd: Permission denied
t@t@re/locale/en_US/LC_MESSAGES/make.momake: /bin/sh: Command not found
 t@ t@Rules.make:288: .depend: No such file or directory
make: *** No rule to make target `/usr/src/linux-2.4.4.SuSE/include/linux/proc_fs.h',
needed by `init/main.o'.
make: *** No rule to make target `/usr/src/linux-2.4.4.SuSE/include/linux/bootmem.h',
needed by `init/main.o'.
/bin/sh: .ver: No such file or directory

Almost as if the file system gets messed up, btw - the kernel compilation
script and kernel sources are on the server's local filesystem (i.e. not
mounted on a remote server).

Is there anything that I can do to:

<1> Reproduce the error(s) found in /var/log/messages (so, at least I'll be
in a better position to find a fix for it)?
<2> Fix the issue by either reconfiguring my setup, or applying a know
fix/patch?

The server is a dual PIII 1GHz, 2GB memory on an Asus CUV4-DLS (we've
recently swapped out the memory as we did get the odd sig 11, but it seems
to be fine now).

I thank you in advance for any help or suggestions.

-- 
Kind regards,

James Chivers

