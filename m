Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130753AbQL2U3X>; Fri, 29 Dec 2000 15:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129572AbQL2U3N>; Fri, 29 Dec 2000 15:29:13 -0500
Received: from tungsten.btinternet.com ([194.73.73.81]:13496 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S132257AbQL2U25>; Fri, 29 Dec 2000 15:28:57 -0500
Date: Fri, 29 Dec 2000 19:53:40 +0000 (GMT)
From: Dave Gilbert <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: NFS oddity (2.4.0test13pre4ac2 server, 2.0.36/2.2.14 clients)
Message-ID: <Pine.LNX.4.10.10012291946180.26235-100000@tardis.home.dave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  On the server:

bash$ ls -l
total 21
drwxrwxrwx  11 root     root         2048 Jul 23 02:32 arm
lrwxrwxrwx   1 root     root           14 Aug 22  1999 dg ->
/home/gilbertd
drwxr-xr-x   6 root     root         1024 Mar 21  1999 ftp
drwx------   5 g3oag    g3oag        1024 Oct  3  1999 g3oag
drwxr-xr-x 164 gilbertd gilbertd    12288 Dec 29 19:42 gilbertd
drwxr-xr-x   5 root     root         1024 Sep 21  1999 httpd
drwxr-xr-x   2 root     root         1024 Mar  8  2017 lost+found
drwx------   2 rmk      rmk          1024 Apr 11  1999 rmk
drwx------   5 rt       rt           1024 Sep 10 14:49 rt
drwxr-xr-x   2 root     nobody       1024 Apr 16  1999 samba

on the client:

[root@sol home]# ls -l
ls: gilbertd: No such file or directory
total 9
drwxrwxrwx   11 root     root         2048 Jul 23 02:32 arm
lrwxrwxrwx    1 root     root           14 Aug 22  1999 dg -> /home/gilbertd
drwxr-xr-x    6 root     root         1024 Mar 21  1999 ftp
drwx------    5 1000     1000         1024 Oct  3 1999 g3oag
drwxr-xr-x    5 root     root         1024 Sep 21  1999 httpd
drwxr-xr-x    2 root     root         1024 Mar  8  2017 lost+found
drwx------    2 9032     9032         1024 Apr 11  1999 rmk
drwx------    5 9033     9033         1024 Sep 10 14:49 rt
drwxr-xr-x    2 root     nobody       1024 Apr 16  1999 samba                  

-------------------------

So where did the gilbertd directory go ?

The Server is Linux/Alpha 2.4.0-test13pre4ac2
The clients are Linux/x86 2.0.36
            and Linux/SPARC 2.2.14

What gives ?

Dave
-- 
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert      | Running GNU/Linux on       |  Happy  \ 
\   gro.gilbert @ treblig.org |  Alpha, x86, ARM and SPARC |  In Hex /
 \ ___________________________|___ http://www.treblig.org  |________/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
