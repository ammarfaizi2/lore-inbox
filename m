Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131444AbQKAWRy>; Wed, 1 Nov 2000 17:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131673AbQKAWRo>; Wed, 1 Nov 2000 17:17:44 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:37902 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131444AbQKAWRd>;
	Wed, 1 Nov 2000 17:17:33 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Skip Collins <bernard.collins@jhuapl.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: screensaver locks up 2.4.0-test10-pre7 hard 
In-Reply-To: Your message of "Wed, 01 Nov 2000 09:43:16 CDT."
             <3A002C04.D4CCA58D@jhuapl.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 02 Nov 2000 09:17:25 +1100
Message-ID: <28632.973117045@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Nov 2000 09:43:16 -0500, 
Skip Collins <bernard.collins@jhuapl.edu> wrote:
>Pentium 3, 256Mb RAM, kernel 2.4.0-test10-pre7 (as well as 2.4.0-test9).
>I installed RH7, compiled the latest development kernels (using kgcc, as
>required with RH7). After the "greynetic" screensaver (installed with
>RH7) runs for a few minutes, my box freezes up hard.

Try the kernel debugging patch[1], select NMI oopser for uniprocessor
if your box is UP and reproduce the problem.  The UP NMI oopser should
drop into kdb after 5 seconds and you can use the bt command to find
out where your system is hanging.  You will have to compile for a
serial console[2] and run a null modem to a second machine to get into
kdb, kdb requires a text or serial console and is not usable under X.

Feel free to contact me off list if you have any problems with kdb.

[1] ftp://oss.sgi.com/projects/kdb/download/ix86.  Patches for test9
    and earlier are in the old directory.
[2] linux/Documentation/serial-console.txt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
