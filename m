Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129040AbQKIQBX>; Thu, 9 Nov 2000 11:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129147AbQKIQBN>; Thu, 9 Nov 2000 11:01:13 -0500
Received: from chaos.analogic.com ([204.178.40.224]:61312 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129040AbQKIQBC>; Thu, 9 Nov 2000 11:01:02 -0500
Date: Thu, 9 Nov 2000 11:00:22 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andrea Pintori <1997s112@educ.disi.unige.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.2.17 bug found
In-Reply-To: <Pine.LNX.3.91.1001109171915.5142B-100000@aries>
Message-ID: <Pine.LNX.3.95.1001109104830.10062A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2000, Andrea Pintori wrote:

> I've a Debian dist, Kernel 2.2.17, no patches, all packages are stable.
> 
> here what I found:
> 
> [/tmp] mkdir old
> [/tmp] chdir old
> [/tmp/old] mv . ../new
> [/tmp/old]                    (should be /tmp/new !!)

The shell might not read this all the while so the name you see
may not change until you change directory.

> [/tmp/old] mkdir fff
> error: cannot write...

This should not happen and it doesn't happen in kernel version 2.4.0-test0

> [tmp/old] ls > fff
> error: cannot write...
> [/tmp/old] ls -la
> total 0                         (?)
> [/tmp/old] cd ..
> [/tmp] ls -la
> *****************       ./
> *****************       ../
> *****************       new/
> 


Script started on Thu Nov  9 10:45:35 2000
# pwd
/tmp
# mkdir old
# cd old
# pwd
/tmp/old
# mv ../old ../new
# pwd
/tmp/old       The shell hasn't re-read the current directory
# ls
# >foo		Make a file called foo
# ls
foo		It's there okay
# rm foo	Remove the file 
# mkdir bar	Make a directory
# ls
bar		It's there
# cd bar
# pwd
/tmp/new/bar	Now, the shell re-read the directory, it is correct
# cd ..
# pwd
/tmp/new	Back where we were, shell reads correct directory.
# cd ..
# ls
new  typescript
# rm -r new
# exit
exit

Script done on Thu Nov  9 10:47:23 2000



Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
