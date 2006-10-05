Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWJEVvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWJEVvL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWJEVvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:51:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55983 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932302AbWJEVvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:51:05 -0400
Date: Thu, 5 Oct 2006 14:50:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sct@redhat.com,
       adilger@clusterfs.com, ext2-devel@lists.sourceforge.net
Subject: Re: 2.6.18-mm2: ext3 BUG?
Message-Id: <20061005145042.fd62289a.akpm@osdl.org>
In-Reply-To: <45257A6C.3060804@gmail.com>
References: <45257A6C.3060804@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Oct 2006 23:34:13 +0159
Jiri Slaby <jirislaby@gmail.com> wrote:

> Hello,
> 
> while yum update-ing, yum crashed and this appeared in log:
> [ 2840.688718] EXT3-fs error (device hda2): ext3_free_blocks_sb: bit already 
> cleared for block 747938
> [ 2840.688732] Aborting journal on device hda2.
> [ 2840.688858] ext3_abort called.
>
> ...
>
> I don't know how to reproduce it and really have no idea what version of -mm 
> could introduce it (if any).

I don't necessarily see a bug in there.  The filesystem got a bit noisy but
did appropriately detect and handle the metadata inconsistency.

The next step would be to fsck that filesystem, see waht it says.
