Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265859AbTL3R1n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 12:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265867AbTL3R1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 12:27:43 -0500
Received: from amber.ccs.neu.edu ([129.10.116.51]:7335 "EHLO amber.ccs.neu.edu")
	by vger.kernel.org with ESMTP id S265859AbTL3R1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 12:27:39 -0500
Subject: Re: SCO's infringing files list
From: Stan Bubrouski <stan@ccs.neu.edu>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <200312301517.27857.bruno@clisp.org>
References: <200312301517.27857.bruno@clisp.org>
Content-Type: text/plain
Message-Id: <1072805257.1760.13.camel@duergar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 30 Dec 2003 12:27:38 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bruno,

Nice work! How many more files left unexplained?

-sb

On Tue, 2003-12-30 at 09:17, Bruno Haible wrote:
> Here's some info about include/linux/ipc.h, also in SCO's list.
> 
> * lxr.linux.no shows that since version 1.0.9, it had only small incremental
>   changes.
> 
> The earliest copy of this file that I've got is from Krishna
> Balasubramanian's ipcbeta+.tar.Z file. This was his second or third
> beta release of SysV IPC for Linux. The file is here:
> http://www.haible.de/bruno/ipcbeta+.tar.Z
> 
> * The include/linux/ipc.h from ipcbeta+.tar.Z is the same as the one in
>   linux-1.0.9 (http://lxr.linux.no/source/include/linux/ipc.h?v=1.0.9)
> 
> I claim that Krishna Balasubramanian wrote this file.
> 
> * The ipcbeta+.tar.Z contents shows how he developed this thing:
>   He looked at various documentation sources (books, manual pages - remember
>   POSIX didn't specify IPC at that time -).
>   He collected some examples like the "dining philosophers" that were floating
>   around on the net.
>   We ran some test programs on other Unices (SunOS 4, possibly also HP-UX).
>   He wrote 40 KB of documentation, explaining each and every system call.
>   ... and someone who puts so much work in testing and documentation should
>   steal the header file??!
> 
> * The value of IPC_PRIVATE is different in Linux. SysV systems define it as
>   (key_t)0, Linux defines it as ((key_t) 0), which extra parentheses.
> 
> * The members of 'struct ipc_perm' are in different order on Linux.
>   SysV systems have them in the order
>      uid, gid, cuid, cgid, mode, seq, key.
>   Linux has them in the order
>      key, uid, gid, cuid, cgid, mode, seq.
> 
> * The values for IPC_CREAT, IPC_EXCL, IPC_NOWAIT are written as octal numbers,
>   which is quite natural, since 9 bits having the same rwxrwxrwx semantics as
>   file permissions can be ORed into it. SysV systems write these constants
>   with 7 octal digits. Linux ipc.h writes them with 8 octal digits.
> 
> * The values of IPC_RMID, IPC_SET, IPC_STAT are different: on Solaris
>   10, 11, 12; on Linux 0, 1, 2.
> 
> * 'struct ipc_kludge' and the corresponding #defines for SEMOP, SEMGET etc.
>   don't exist in SysV systems. They arose only because we wanted to minimize
>   the number of system calls.
> 
> I hope that's enough evidence that Krishna didn't copy the file's contents
> from anywhere.
> 
> Bruno
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

