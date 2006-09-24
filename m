Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWIXRIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWIXRIb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 13:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWIXRIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 13:08:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20650 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751156AbWIXRIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 13:08:31 -0400
Date: Sun, 24 Sep 2006 10:08:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git patch] add and use include/linux/magic.h
In-Reply-To: <20060924161809.GA13423@havoc.gtf.org>
Message-ID: <Pine.LNX.4.64.0609241005290.4388@g5.osdl.org>
References: <20060924161809.GA13423@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Sep 2006, Jeff Garzik wrote:
> 
> Along the lines of linux/poison.h, do a similar thing with filesystem
> superblock (and later perhaps, other) magic numbers.  This permits
> us to delete several headers which -only- included the superblock
> magic number, and it integrates well with dwmw2's header_check /
> header_install stuff.

Ok, I'm a little worried that somebody might want its own magic number, 
but not have its namespace poisoned by other peoples magic numbers (think 
some user-level program like "e2fsck"), but I guess it's unlikely to be a 
real problem.

Pulled.

One more thing: your "please pull" looks fine, but if you were to also add 
the "--summary" argument to the diffstat generation, I'd have seen:

> Please pull from 'magic' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git magic
> 
> to receive the following updates:
> 
>  fs/affs/affs.h               |    1 -
>  fs/affs/super.c              |    1 +
> ....
>  include/linux/smb.h          |    3 +--
>  include/linux/usbdevice_fs.h |    3 +--
>  30 files changed, 67 insertions(+), 85 deletions(-)

followed by:

 delete mode 100644 include/linux/affs_fs.h
 delete mode 100644 include/linux/hpfs_fs.h
 create mode 100644 include/linux/magic.h
 delete mode 100644 include/linux/openprom_fs.h

which is nice. You see which files actually disappear or appear (or are 
renamed). Ok?

		Linus
