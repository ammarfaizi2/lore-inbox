Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVCZDjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVCZDjo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 22:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVCZDjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 22:39:44 -0500
Received: from fire.osdl.org ([65.172.181.4]:5257 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261927AbVCZDjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 22:39:42 -0500
Date: Fri, 25 Mar 2005 19:39:39 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, torvalds@osdl.org, akpm@osdl.org
Subject: Linux 2.6.11.6
Message-ID: <20050326033939.GV30522@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With some pending security fixes it's time to for a -stable update.  So,
here's 2.6.11.6, in the normal kernel.org places.  This includes some
security fixes, esp. one which closes a local root exploit in bluetooth.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.11.5 and 2.6.11.6, as it is small enough to do so.


thanks,
-chris
--

 Makefile                     |    2 +-
 fs/binfmt_elf.c              |   30 +++++++++++++++++-------------
 fs/ext2/dir.c                |    1 +
 fs/isofs/inode.c             |    5 +++++
 fs/isofs/rock.c              |   25 ++++++++++++++++++-------
 net/bluetooth/af_bluetooth.c |    6 +++---
 6 files changed, 45 insertions(+), 24 deletions(-)

Summary of changes from v2.6.11.5 to v2.6.11.6
==============================================

Chris Wright:
  o isofs: more defensive checks against corrupt isofs images
  o Linux 2.6.11.6

Herbert Xu:
  o Potential DOS in load_elf_library

Linus Torvalds:
  o isofs: Handle corupted rock-ridge info slightly better
  o isofs: more "corrupted iso image" error cases

Marcel Holtmann:
  o Fix signedness problem at socket creation

Mathieu Lafon:
  o Suspected information leak (mem pages) in ext2
