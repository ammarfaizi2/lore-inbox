Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131728AbQL2XbJ>; Fri, 29 Dec 2000 18:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130061AbQL2Xa7>; Fri, 29 Dec 2000 18:30:59 -0500
Received: from gadolinium.btinternet.com ([194.73.73.111]:13777 "EHLO
	gadolinium.btinternet.com") by vger.kernel.org with ESMTP
	id <S131728AbQL2Xas>; Fri, 29 Dec 2000 18:30:48 -0500
Date: Fri, 29 Dec 2000 22:55:19 +0000 (GMT)
From: Dave Gilbert <gilbertd@treblig.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: NFS oddity (2.4.0test13pre4ac2 server, 2.0.36/2.2.14 clients)
In-Reply-To: <14924.64601.485759.167765@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.10.10012292252450.26235-100000@tardis.home.dave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Dec 2000, Neil Brown wrote:

> > So where did the gilbertd directory go ?
> 
> Is there any chance that /home/gilbertd is a mount point?

Nope; from the server:

[root@tardis gcc]# mount
/dev/hdc6 on / type ext2 (rw)
none on /proc type proc (rw)
/dev/hdc3 on /discs/c3 type ext2 (ro)
/dev/hdc4 on /discs/c4 type ext2 (rw)
/dev/hdc7 on /discs/c7 type ext2 (rw)
/dev/hdc8 on /discs/c8 type ext2 (rw)

(/home is actually /discs/c4/home).

/etc/exports is:

/discs/c4 sol(rw,no_root_squash,insecure) gort klaatu 
     oaktree(rw,no_root_squash,insecure)  
/discs/c3 sol(rw,no_root_squash,insecure) gort klaatu
     oaktree(rw,no_root_squash,insecure)  
/mnt/dvd sol(rw,no_root_squash,insecure)

Server is tardis, client is sol.


> Can you get a tcpdump (-s 1024) of the network traffic while this is
> happening?

Yep; to avoid posting to the list I've put it at:
http://www.treblig.org/nfs_bug_netlog

its 14K and is the output of:

 /usr/sbin/tcpdump -vv -x -s 1024 host sol and tardis > /tmp/netlog 2>&1

Thanks,

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
