Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263125AbUD2D4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbUD2D4z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 23:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbUD2D4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 23:56:55 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:5480 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263125AbUD2D4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 23:56:51 -0400
Date: Wed, 28 Apr 2004 22:55:42 -0500 (CDT)
From: Brent Cook <busterbcook@yahoo.com>
X-X-Sender: busterb@ozma.hauschen
Reply-To: busterbcook@yahoo.com
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: busterbcook@yahoo.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: pdflush eating a lot of CPU on heavy NFS I/O
In-Reply-To: <1083187174.2856.162.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.58.0404282254290.13673@ozma.hauschen>
References: <Pine.LNX.4.58.0404280009300.28371@ozma.hauschen> 
 <20040427230203.1e4693ac.akpm@osdl.org>  <Pine.LNX.4.58.0404280826070.31093@ozma.hauschen>
  <20040428124809.418e005d.akpm@osdl.org>  <Pine.LNX.4.58.0404281534110.3044@ozma.hauschen>
 <1083187174.2856.162.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004, Trond Myklebust wrote:

> On Wed, 2004-04-28 at 16:39, Brent Cook wrote:
> > > Could you please capture the contents of /proc/meminfo and /proc/vmstats
> > > when it's happening?
> > >
> > > Thanks.
> > >
> >
> > Here is the top of top for one machine:
> >
> >  15:36:55  up  7:09,  1 user,  load average: 1.00, 1.00, 1.00
> > 48 processes: 46 sleeping, 2 running, 0 zombie, 0 stopped
> > CPU states:   0.1% user  99.8% system   0.0% nice   0.0% iowait   0.0% idle
> > Mem:   256992k av,  117644k used,  139348k free,       0k shrd,   36464k buff
> >         50968k active,              51592k inactive
> > Swap:  514040k av,       0k used,  514040k free                   61644k cached
> >
> >   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
> >     7 root      25   0     0    0     0 RW   99.4  0.0 415:26   0 pdflush
>
> Could you please also supply the mount options you are using as well as
> the contents of /proc/mounts corresponding to your NFS partition.
>
> Cheers,
>   Trond

Here is /proc/mounts on the aforementioned test system:

rootfs / rootfs rw 0 0
/dev/root / reiserfs rw 0 0
devpts /dev/pts devpts rw 0 0
proc /proc proc rw,nodiratime 0 0
none /sys sysfs rw 0 0
usbfs /proc/bus/usb usbfs rw 0 0
ozma:/home /home nfs rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=ozma 0 0

 - Brent
