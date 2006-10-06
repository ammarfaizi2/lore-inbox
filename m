Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbWJFATy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWJFATy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 20:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWJFATx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 20:19:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1495 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932485AbWJFATx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 20:19:53 -0400
Date: Thu, 5 Oct 2006 17:14:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sct@redhat.com,
       adilger@clusterfs.com, ext2-devel@lists.sourceforge.net
Subject: Re: 2.6.18-mm2: ext3 BUG?
Message-Id: <20061005171428.636c087c.akpm@osdl.org>
In-Reply-To: <4525925C.6060807@gmail.com>
References: <45257A6C.3060804@gmail.com>
	<20061005145042.fd62289a.akpm@osdl.org>
	<4525925C.6060807@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Oct 2006 01:16:21 +0159
Jiri Slaby <jirislaby@gmail.com> wrote:

> Andrew Morton wrote:
> > On Thu, 05 Oct 2006 23:34:13 +0159
> > Jiri Slaby <jirislaby@gmail.com> wrote:
> > 
> >> Hello,
> >>
> >> while yum update-ing, yum crashed and this appeared in log:
> >> [ 2840.688718] EXT3-fs error (device hda2): ext3_free_blocks_sb: bit already 
> >> cleared for block 747938
> >> [ 2840.688732] Aborting journal on device hda2.
> >> [ 2840.688858] ext3_abort called.
> >>
> >> ...
> >>
> >> I don't know how to reproduce it and really have no idea what version of -mm 
> >> could introduce it (if any).
> > 
> > I don't necessarily see a bug in there.  The filesystem got a bit noisy but
> > did appropriately detect and handle the metadata inconsistency.
> 
> Perhaps, but why did it occur? S.m.a.r.t. doesn't tell me anything suspicious.

Don't know.  The usual diagnosis for this sort of thing is "your disk shat
itself".  Could be a bad disk, bad power supply, bad memory, some piece of
kernel code went and trashed some memory, bug in the driver.  It's a
mystery, sorry.


