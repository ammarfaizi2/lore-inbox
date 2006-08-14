Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbWHNRRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbWHNRRR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 13:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWHNRRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 13:17:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20630 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932496AbWHNRRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 13:17:16 -0400
Date: Mon, 14 Aug 2006 10:16:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: Ian Kent <raven@themaw.net>, linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: 2.6.18-rc4-mm1
Message-Id: <20060814101657.8c5b796a.akpm@osdl.org>
In-Reply-To: <15771.1155547930@warthog.cambridge.redhat.com>
References: <1155542805.3430.5.camel@raven.themaw.net>
	<20060813012454.f1d52189.akpm@osdl.org>
	<20060813133935.b0c728ec.akpm@osdl.org>
	<15771.1155547930@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2006 10:32:10 +0100
David Howells <dhowells@redhat.com> wrote:

> Ian Kent <raven@themaw.net> wrote:
> 
> > I'm having trouble duplicating this.
> > Is there any more info. about this I'm missing?
> 
> Works fine for me also.
> 
> Andrew, can you do the following:
> 
> 	cat /proc/fs/nfsfs/*

sony:/home/akpm> cat /proc/fs/nfsfs/*
NV SERVER   PORT USE HOSTNAME
NV SERVER   PORT DEV     FSID              FSC

sony:/home/akpm> ls -l /net/bix
total 1025280
drwxr-xr-x  3 root root       4096 Apr 10 03:19 bin
drwxr-xr-x  2 root root       4096 Mar 10  2004 boot
drwxr-xr-x 23 root root     118784 Jun 26 00:48 dev
drwxr-xr-x 98 root root       8192 Aug 14 04:03 etc
drwxr-xr-x  7 root root       4096 Apr  1  2004 home
drwxr-xr-x  2 root root       4096 Oct  7  2003 initrd
drwxr-xr-x 10 root root       4096 Apr 10 03:19 lib
drwx------  2 root root      16384 Mar 10  2004 lost+found
drwxr-xr-x  2 root root       4096 Sep  8  2003 misc
?---------  ? ?    ?             ?            ? /net/bix/mnt
?---------  ? ?    ?             ?            ? /net/bix/usr
drwxrwxrwx  8 root root       4096 Jul 10 02:50 opt
drwxr-xr-x  2 root root       4096 Mar 10  2004 proc
drwxr-xr-x 20 root root       4096 Aug  7 16:39 root
drwxr-xr-x  2 root root      57344 Apr 24  2004 rpms
drwxr-xr-x  2 root root       8192 Apr 10 03:19 sbin
-rw-r--r--  1 root root 1048576000 Mar 12  2004 swap
drwxr-xr-x  2 root root       4096 Mar 12  2004 sys
drwxr-xr-x  3 root root       4096 Mar 10  2004 tftpboot
drwxrwxrwt 14 root root      16384 Aug 14 09:57 tmp
drwxr-xr-x 27 root root       4096 Mar 10  2004 var
sony:/home/akpm> cat /proc/fs/nfsfs/*
NV SERVER   PORT USE HOSTNAME
v3 c0a80221  801   1 bix
NV SERVER   PORT DEV     FSID              FSC
v3 c0a80221  801 0:21    802:0             no 

> And can you try mounting "bix:/" manually to see if that exhibits the same
> problem?

sony:/home/akpm# mount bix:/ /mnt/bix
sony:/home/akpm# ls -l /mnt/bix
total 1025288
drwxr-xr-x  3 root root       4096 Apr 10 03:19 bin
drwxr-xr-x  2 root root       4096 Mar 10  2004 boot
drwxr-xr-x 23 root root     118784 Jun 26 00:48 dev
drwxr-xr-x 98 root root       8192 Aug 14 04:03 etc
drwxr-xr-x  7 root root       4096 Apr  1  2004 home
drwxr-xr-x  2 root root       4096 Oct  7  2003 initrd
drwxr-xr-x 10 root root       4096 Apr 10 03:19 lib
drwx------  2 root root      16384 Mar 10  2004 lost+found
drwxr-xr-x  2 root root       4096 Sep  8  2003 misc
drwxr-xr-x 19 root root       4096 Jul  3 15:29 mnt
drwxrwxrwx  8 root root       4096 Jul 10 02:50 opt
drwxr-xr-x  2 root root       4096 Mar 10  2004 proc
drwxr-xr-x 20 root root       4096 Aug  7 16:39 root
drwxr-xr-x  2 root root      57344 Apr 24  2004 rpms
drwxr-xr-x  2 root root       8192 Apr 10 03:19 sbin
-rw-r--r--  1 root root 1048576000 Mar 12  2004 swap
drwxr-xr-x  2 root root       4096 Mar 12  2004 sys
drwxr-xr-x  3 root root       4096 Mar 10  2004 tftpboot
drwxrwxrwt 14 root root      16384 Aug 14 09:57 tmp
drwxr-xr-x 17 root root       4096 Mar 22  2005 usr
drwxr-xr-x 27 root root       4096 Mar 10  2004 var
sony:/home/akpm# mount bix:/usr/src /mnt/bix/usr/src
sony:/home/akpm# ls -l /mnt/bix                     
total 1025288
drwxr-xr-x  3 root root       4096 Apr 10 03:19 bin
drwxr-xr-x  2 root root       4096 Mar 10  2004 boot
drwxr-xr-x 23 root root     118784 Jun 26 00:48 dev
drwxr-xr-x 98 root root       8192 Aug 14 04:03 etc
drwxr-xr-x  7 root root       4096 Apr  1  2004 home
drwxr-xr-x  2 root root       4096 Oct  7  2003 initrd
drwxr-xr-x 10 root root       4096 Apr 10 03:19 lib
drwx------  2 root root      16384 Mar 10  2004 lost+found
drwxr-xr-x  2 root root       4096 Sep  8  2003 misc
drwxr-xr-x 19 root root       4096 Jul  3 15:29 mnt
drwxrwxrwx  8 root root       4096 Jul 10 02:50 opt
drwxr-xr-x  2 root root       4096 Mar 10  2004 proc
drwxr-xr-x 20 root root       4096 Aug  7 16:39 root
drwxr-xr-x  2 root root      57344 Apr 24  2004 rpms
drwxr-xr-x  2 root root       8192 Apr 10 03:19 sbin
-rw-r--r--  1 root root 1048576000 Mar 12  2004 swap
drwxr-xr-x  2 root root       4096 Mar 12  2004 sys
drwxr-xr-x  3 root root       4096 Mar 10  2004 tftpboot
drwxrwxrwt 14 root root      16384 Aug 14 09:57 tmp
drwxr-xr-x 17 root root       4096 Mar 22  2005 usr
drwxr-xr-x 27 root root       4096 Mar 10  2004 var
sony:/home/akpm# ls -l /mnt/bix/usr/src
total 1049780
drwxr-xr-x 21 akpm akpm       4096 Jun 17 16:02 24
lrwxrwxrwx  1 akpm akpm          5 Jan 23  2006 25 -> devel
drwxr-xr-x 27 akpm akpm       4096 May 20 01:44 25-alpha
...

>  It'd be useful to know if autofs is actually having an effect.

Everything seems OK doing it by hand.

> Also, can you do a module list and check that it's autofs4 that's being used,
> and not autofs.

sony:/home/akpm# lsmod|grep auto
autofs4                20228  1 

>  It would be handy if we could rule out an adverse interaction
> between nfs and autofs4.

I'd say that's exactly what it is.

> > Bisection shows that the bug is introduced by git-nfs.patch.
> 
> But what does it actually show?  Do you know where the bug is then?  (I don't
> know exactly how bisection works).
> 

I mean: bisection searching through the rc4-mm1 patch pile indicates that:

everything up to but not including git-nfs.patch: OK
add git-nfs.patch to the above: fails.

The server is running 2.6.17-rc1-mm3, if that matters.  (It shouldn't:
git-nfs.patch has changed the client's behaviour).

And, as I said, this machine is running stock mostly-up-to-date FC5.

sony:/home/akpm> rpm -q autofs
autofs-4.1.4-29
sony:/home/akpm> rpm -V autofs
sony:/home/akpm> 


