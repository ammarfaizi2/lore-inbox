Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129552AbQL2Lnb>; Fri, 29 Dec 2000 06:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129781AbQL2LnV>; Fri, 29 Dec 2000 06:43:21 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:14279 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129552AbQL2LnE>; Fri, 29 Dec 2000 06:43:04 -0500
Date: Fri, 29 Dec 2000 06:13:17 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: John Summerfield <summer@os2.ami.com.au>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at buffer.c:765
In-Reply-To: <200012290052.IAA08785@dugite.os2.ami.com.au>
Message-ID: <Pine.LNX.4.31.0012290610050.802-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Dec 2000, John Summerfield wrote:

>[root@dugite /root]# sfdisk -l /dev/sda
>ll_rw_block: device 08:00: only 2048-char blocks implemented (1024)
>kernel BUG at buffer.c:765!
>invalid operand: 0000
>CPU:    0
>EIP:    0010:[<c012f0cd>]
>EFLAGS: 00010282
>eax: 0000001c   ebx: c1b91ac8   ecx: c029ca68   edx: c029ca68
>esi: 00000001   edi: 00000001   ebp: c1f55f2c   esp: c1f55ef0
>ds: 0018   es: 0018   ss: 0018
>Process sfdisk (pid: 1323, stackpage=c1f55000)
>Stack: c024aba5 c024ae5a 000002fd c1b91a80 c017a4c4 c1b91a80 00000000 00000000
>       bffffaa8 c1f55f78 c1215400 c012f663 00000000 00000001 c1f55f2c c1b91a80
>       c01c8a68 00000800 00000000 00000400 00000000 bffffaa8 bffffaa8 00000800
>Call Trace: [<c024aba5>] [<c024ae5a>] [<c017a4c4>] [<c012f663>] [<c01c8a68>] [<c01ce84e>] [<c01349b1>]
>       [<c013ad96>] [<c010a933>]
>Code: 0f 0b 83 c4 0c 5b c3 55 57 56 53 8b 74 24 14 8b 54 24 18 85
>eth0: Abnormal interrupt, status 00000051.
>eth0: Abnormal interrupt, status 00000010.
>eth0: Abnormal interrupt, status 00000020.
>Segmentation fault
>[root@dugite /root]# uname -a
>Linux dugite 2.4.0-test12 #11 Wed Dec 20 16:28:41 WST 2000 i586 unknown
>[root@dugite /root]#
>

You'll need to run that through ksymoops first John, or else the
Oops report is not very useful since the kernel offsets are
different for every kernel compile.  If you put the System.map
file in /boot, you should end up with symbolic Oops information
in your /var/log/messages after a reboot.

Without that info, the above addresses effectively point to
nowhere.

Hope this helps.
Happy New Year!


----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2000, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

And 1.1.81 is officially BugFree(tm), so if you receive any bug-reports
on it, you know they are just evil lies.
  -- Linus Torvalds

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
