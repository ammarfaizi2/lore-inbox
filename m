Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbWBFDPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWBFDPZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 22:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbWBFDPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 22:15:25 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:12930 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1750918AbWBFDPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 22:15:25 -0500
Message-ID: <43E6BF48.5010301@namesys.com>
Date: Sun, 05 Feb 2006 19:15:20 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Jeff Mahoney <jeffm@suse.com>, LKML <linux-kernel@vger.kernel.org>,
       kernel-bugzilla@luksan.cjb.net
Subject: quality control
References: <43E64791.8010302@namesys.com> <43E6521F.5020707@suse.com>
In-Reply-To: <43E6521F.5020707@suse.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dearest HCH,

Please consider adhering to a quality control process.  No patch comes
out of Namesys without a second person testing it (that includes
compiling it).  Users should not be burdened with code that has not been
tested by a second person.  Everyone makes mistakes of this kind, the
difference is that some persons use a quality control process to avoid
burdening more than one other person with them.

Hans

Jeff Mahoney wrote:

> Hans Reiser wrote:
>
> >http://bugzilla.kernel.org/show_bug.cgi?id=6016
>
> >           Summary: reiserfs doesn't build with REISERFS_FS_POSIX_ACL=n
> >    Kernel Version: v2.6.16-rc2-g5b7b644
> >            Status: NEW
> >          Severity: normal
> >             Owner: reiserfs-dev@namesys.com
> >         Submitter: kernel-bugzilla@luksan.cjb.net
>
>
> >Most recent kernel where this bug did not occur: 2.6.16-rc1
> >Distribution: Gentoo
> >Hardware Environment: amd64
> >Problem Description:
>
> >reiserfs doesn't build with REISERFS_FS_POSIX_ACL=n
>
> >Steps to reproduce:
> >$ make
> >  CHK     include/linux/version.h
> >  SPLIT   include/linux/autoconf.h -> include/config/*
> >  CHK     include/linux/compile.h
> >  CHK     usr/initramfs_list
> >  GZIP    kernel/config_data.gz
> >  IKCFG   kernel/config_data.h
> >  CC      kernel/configs.o
> >  LD      kernel/built-in.o
> >  CC      fs/reiserfs/xattr.o
> >fs/reiserfs/xattr.c: In function `reiserfs_check_acl':
> >fs/reiserfs/xattr.c:1330: error: called object is not a function
> >make[2]: *** [fs/reiserfs/xattr.o] Error 1
> >make[1]: *** [fs/reiserfs] Error 2
> >make: *** [fs] Error 2
>
> >Reverting ec191574b9c3cb7bfb95e4f803b63f7c8dc52690
> >---
> >[PATCH] reiserfs: use generic_permission
>
> >Use the generic_permission code with a proper wrapper and callback
> instead
> >of having a local copy.
> >---
> >fixes the problem, but causes some warnings about unused symbols.
>
>
> This was a patch from hch, not me. There's already a patch in -mm to
> fix it.
>
> -Jeff
>
> --
> Jeff Mahoney
> SUSE Labs

