Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbWHONvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbWHONvJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 09:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbWHONvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 09:51:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5324 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030294AbWHONvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 09:51:01 -0400
Date: Tue, 15 Aug 2006 06:50:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ian Kent <raven@themaw.net>
Subject: Re: 2.6.18-rc4-mm1
Message-Id: <20060815065035.648be867.akpm@osdl.org>
In-Reply-To: <918.1155635513@warthog.cambridge.redhat.com>
References: <20060814143110.f62bfb01.akpm@osdl.org>
	<20060813133935.b0c728ec.akpm@osdl.org>
	<20060813012454.f1d52189.akpm@osdl.org>
	<10791.1155580339@warthog.cambridge.redhat.com>
	<918.1155635513@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 10:51:53 +0100
David Howells <dhowells@redhat.com> wrote:

> Andrew Morton <akpm@osdl.org> wrote:
> 
> > bix:/home/akpm> cat /etc/exports
> > /               *(rw,async)
> > /usr/src        *(rw,async)
> > /mnt/export     *(rw,async)
> 
> Hmmm... I still can't reproduce it.

http://www.zip.com.au/~akpm/linux/patches/stuff/config-sony

> What happens if you change your /etc/exports file to:
> 
> /               *(rw,async,fsid=0)
> /usr/src        *(rw,async,nohide)
> /mnt/export     *(rw,async,nohide)

unchanged.

> Also, does removing the "/mnt/export" line from /etc/exports mean that the
> /mnt reappears in the directory listing?
> 

That makes /mnt go away:

sony:/home/akpm> l /net/bix
total 1025284
drwxr-xr-x  3 root root       4096 Apr 10 03:19 bin
drwxr-xr-x  2 root root       4096 Mar 10  2004 boot
drwxr-xr-x 23 root root     118784 Jun 26 00:48 dev
drwxr-xr-x 98 root root       8192 Aug 15 06:46 etc
drwxr-xr-x  7 root root       4096 Apr  1  2004 home
drwxr-xr-x  2 root root       4096 Oct  7  2003 initrd
drwxr-xr-x 10 root root       4096 Apr 10 03:19 lib
drwx------  2 root root      16384 Mar 10  2004 lost+found
drwxr-xr-x  2 root root       4096 Sep  8  2003 misc
drwxr-xr-x 19 root root       4096 Jul  3 15:29 mnt
?---------  ? ?    ?             ?            ? /net/bix/usr
drwxrwxrwx  8 root root       4096 Jul 10 02:50 opt
drwxr-xr-x  2 root root       4096 Mar 10  2004 proc
drwxr-xr-x 20 root root       4096 Aug  7 16:39 root
drwxr-xr-x  2 root root      57344 Apr 24  2004 rpms
drwxr-xr-x  2 root root       8192 Apr 10 03:19 sbin
-rw-r--r--  1 root root 1048576000 Mar 12  2004 swap
drwxr-xr-x  2 root root       4096 Mar 12  2004 sys
drwxr-xr-x  3 root root       4096 Mar 10  2004 tftpboot
drwxrwxrwt 14 root root      16384 Aug 15 06:42 tmp
drwxr-xr-x 27 root root       4096 Mar 10  2004 var

