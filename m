Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752047AbWHNSY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbWHNSY6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 14:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbWHNSY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 14:24:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23213 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752047AbWHNSY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 14:24:57 -0400
Date: Mon, 14 Aug 2006 11:24:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: Ian Kent <raven@themaw.net>, linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: 2.6.18-rc4-mm1
Message-Id: <20060814112435.0c07b248.akpm@osdl.org>
In-Reply-To: <1871.1155579143@warthog.cambridge.redhat.com>
References: <20060814101657.8c5b796a.akpm@osdl.org>
	<1155542805.3430.5.camel@raven.themaw.net>
	<20060813012454.f1d52189.akpm@osdl.org>
	<20060813133935.b0c728ec.akpm@osdl.org>
	<15771.1155547930@warthog.cambridge.redhat.com>
	<1871.1155579143@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2006 19:12:23 +0100
David Howells <dhowells@redhat.com> wrote:

> Andrew Morton <akpm@osdl.org> wrote:
> 
> > ?---------  ? ?    ?             ?            ? /net/bix/mnt
> > ?---------  ? ?    ?             ?            ? /net/bix/usr
> 
> Do /mnt and /usr have other things mounted on them on bix?

nope.

>  Can you dump fstab
> on bix?

bix:/home/akpm> cat /proc/mounts
rootfs / rootfs rw 0 0
/dev/root / ext3 rw,noatime,data=ordered 0 0
/proc /proc proc rw 0 0
none /dev/pts devpts rw 0 0
/dev/sda1 /boot ext3 rw,data=ordered 0 0
none /dev/shm tmpfs rw 0 0
/dev/sdb1 /usr/src ext3 rw,noatime,data=ordered 0 0
none /sys sysfs rw 0 0
/dev/sdb2 /mnt/export ext3 rw,noatime,data=ordered 0 0
nodev /dev/oprofile oprofilefs rw 0 0

> If so, it's possible that the server-mountpoint-crossing automounter internal
> to NFS doesn't like working with autofs.

I'd say it's something like that.  Odd thing is, /mnt and /usr don't have
anything mounted on them.  But they do have a local partition mounted on
subdirectories within them: /mnt/export and /usr/src.

