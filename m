Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131886AbQL2VfZ>; Fri, 29 Dec 2000 16:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132340AbQL2VfQ>; Fri, 29 Dec 2000 16:35:16 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:22536 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S131886AbQL2VfJ>; Fri, 29 Dec 2000 16:35:09 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Dave Gilbert <gilbertd@treblig.org>
Date: Sat, 30 Dec 2000 08:04:25 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14924.64601.485759.167765@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS oddity (2.4.0test13pre4ac2 server, 2.0.36/2.2.14 clients)
In-Reply-To: message from Dave Gilbert on Friday December 29
In-Reply-To: <Pine.LNX.4.10.10012291946180.26235-100000@tardis.home.dave>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday December 29, gilbertd@treblig.org wrote:
> Hi,
>   On the server:
> 
> bash$ ls -l
> total 21
> drwxrwxrwx  11 root     root         2048 Jul 23 02:32 arm
> lrwxrwxrwx   1 root     root           14 Aug 22  1999 dg ->
> /home/gilbertd
> drwxr-xr-x   6 root     root         1024 Mar 21  1999 ftp
> drwx------   5 g3oag    g3oag        1024 Oct  3  1999 g3oag
> drwxr-xr-x 164 gilbertd gilbertd    12288 Dec 29 19:42 gilbertd
....
> 
> on the client:
> 
> [root@sol home]# ls -l
> ls: gilbertd: No such file or directory
> total 9
> drwxrwxrwx   11 root     root         2048 Jul 23 02:32 arm
> lrwxrwxrwx    1 root     root           14 Aug 22  1999 dg -> /home/gilbertd
> drwxr-xr-x    6 root     root         1024 Mar 21  1999 ftp
> drwx------    5 1000     1000         1024 Oct  3 1999 g3oag
....
> -------------------------
> 
> So where did the gilbertd directory go ?

Is there any chance that /home/gilbertd is a mount point?
Can you show us your /etc/exports, just incase there is something
significant there?
Can you get a tcpdump (-s 1024) of the network traffic while this is
happening?

NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
