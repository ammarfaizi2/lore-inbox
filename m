Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154111-31090>; Thu, 24 Dec 1998 17:45:28 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1248 "EHLO chaos.analogic.com" ident: "SOCKWRITE-65") by vger.rutgers.edu with ESMTP id <154601-31090>; Thu, 24 Dec 1998 17:41:37 -0500
Date: Thu, 24 Dec 1998 18:41:19 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Murat Arslan <arslanm@piranha.marketweb.net.tr>
cc: linux-kernel@vger.rutgers.edu, linux-net@vger.rutgers.edu
Subject: Re: [QUESTION] Unix98 pty's
In-Reply-To: <Pine.LNX.4.04.9812241702040.5578-100000@piranha.marketweb.net.tr>
Message-ID: <Pine.LNX.3.95.981224183829.1858B-101000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1295196120-343799173-914542879=:1858"
Sender: owner-linux-kernel@vger.rutgers.edu

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1295196120-343799173-914542879=:1858
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 24 Dec 1998, Murat Arslan wrote:

> 
> Hello,
> 
> I'm running Redhat 5.2 w/ kernel 2.1.131+ac13, done the following:
> 
> - Compiled my kernel with CONFIG_UNIX98_PTYS and CONFIG_DEVPTS_FS.
> - mknod /dev/ptmx c 5 2
> - chmod 666 /dev/ptmx
> - mkdir /dev/pts
> - Added the following to /etc/fstab:
>   none            /dev/pts        devpts        gid=5,mode=620    0 0
> 
> Major/minor nums of /dev/tty* and /dev/pty* are:
> root@7:57pm:~# ls -l /dev/tty* 
> crw-rw-rw-   1 root     root       5,   0 May  5  1998 /dev/tty
> crw-------   1 arslanm  staff      4,   0 May  5  1998 /dev/tty0
> crw--w----   1 root     tty        4,   1 Dec 23 17:57 /dev/tty1
> crw-------   1 arslanm  staff      4,  10 Sep 11 04:13 /dev/tty10
> crw-------   1 root     tty        4,  11 Sep 11 04:13 /dev/tty11
> crw-------   1 root     tty        4,  12 Sep 11 04:13 /dev/tty12
> ...
> 
> root@7:57pm:~# ls -l /dev/pty*
> crw-rw-rw-   1 root     tty        2, 176 May  5  1998 /dev/ptya0
> crw-rw-rw-   1 root     tty        2, 177 May  5  1998 /dev/ptya1
> crw-rw-rw-   1 root     tty        2, 178 May  5  1998 /dev/ptya2
> crw-rw-rw-   1 root     tty        2, 179 May  5  1998 /dev/ptya3
> crw-rw-rw-   1 root     tty        2, 180 May  5  1998 /dev/ptya4
> crw-rw-rw-   1 root     tty        2, 181 May  5  1998 /dev/ptya5
> 
> But still nothing happened,
> 
> Did I miss anything ??
> 
> In Documentation/Changes it says:
> If you want to use the Unix98 ptys, you should be running at least
> glibc-2.0.9x, and you must switch completely to Unix98 pty's.
> 
> How can I "completely" switch to Unix98 pty's ?
> 
> Regards,

It is a FAQ. Uncrunch this, put it in /dev as MAKEDEV.new and
execute...

./MAKEDEV.new generic


Cheers,
Dick Johnson
                 ***** FILE SYSTEM WAS MODIFIED *****
Penguin : Linux version 2.1.131 on an i686 machine (400.59 BogoMips).
Warning : It's hard to remain at the trailing edge of technology.

---1295196120-343799173-914542879=:1858
Content-Type: APPLICATION/octet-stream; name="MAKEDEV.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.95.981224184119.1858C@chaos.analogic.com>
Content-Description: 

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
xnTYGOOHugeoGBh3/tR1vr8DZ4SwRk09AAA=
---1295196120-343799173-914542879=:1858--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
