Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290843AbSCOLad>; Fri, 15 Mar 2002 06:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290983AbSCOLaX>; Fri, 15 Mar 2002 06:30:23 -0500
Received: from ns.ithnet.com ([217.64.64.10]:59152 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S290843AbSCOLaO>;
	Fri, 15 Mar 2002 06:30:14 -0500
Date: Fri, 15 Mar 2002 12:30:08 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Oleg Drokin <green@namesys.com>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-Id: <20020315123008.14237953.skraw@ithnet.com>
In-Reply-To: <20020315141328.A1879@namesys.com>
In-Reply-To: <200203110018.BAA11921@webserver.ithnet.com>
	<15499.64058.442959.241470@charged.uio.no>
	<20020311091458.A24600@namesys.com>
	<20020311114654.2901890f.skraw@ithnet.com>
	<20020311135256.A856@namesys.com>
	<20020311155937.A1474@namesys.com>
	<20020315141328.A1879@namesys.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2002 14:13:28 +0300
Oleg Drokin <green@namesys.com> wrote:

> Hello!
> 
> On Fri, Mar 15, 2002 at 12:02:32PM +0100, Stephan von Krawczynski wrote:
> > > Ok I tried your scenario of mounting fs1, then mounting fs2, do io on fs2,
> > > umount fs2 and access fs1 and everything went fine.
> > > I cannot reproduce this at all. :(
> > There must be a reason for this. One "non-standard" option in my setup is in /etc/exports:
> > /p2/backup              192.168.1.1(rw,no_root_squash,no_subtree_check)
> > Can the "no_subtree_check" be a cause?
> I will try with this one.
> BTW how much i/o do you usually do to observe an effect.

Very low. Something like 10 MB reading files on the server. My standard way of producing it is mounting the backup fs and then starting yast (SuSE config tool), which is configured to read the data from (the same) nfs-server. Scroll around in the packet selection a bit and exit the tool without installing something. I cannot see however how YaST mounts the fs (which options on mount command). Maybe someone from SuSE can clarify?

> Are exported filesystems actually reside on one physical flesystem on server

No. They are on different filesystems.

> or they are separate physical filesystems too?
> 
> > What kernels are you using (client,server)?
> 2.4.18 at both sides.

Another point to clarify, my client fstab entry looks like this:

192.168.1.2:/p2/backup  /backup                 nfs     timeo=20,dev,suid,rw,exec,user,rsize=8192,wsize=8192       0 0

I cannot say anything about the second fs mounted via YaST.

Regards,
Stephan


