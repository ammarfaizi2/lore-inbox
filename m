Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbUCLIw5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 03:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbUCLIw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 03:52:57 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:33032 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262041AbUCLIwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 03:52:54 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.4-mm1: modular quota needs unknown symbol
Date: Fri, 12 Mar 2004 09:51:57 +0100
User-Agent: KMail/1.6.1
Cc: Adrian Bunk <bunk@fs.tum.de>, ext3-users@redhat.com
References: <20040310233140.3ce99610.akpm@osdl.org> <20040311202352.GD14833@fs.tum.de>
In-Reply-To: <20040311202352.GD14833@fs.tum.de>
X-Operating-System: Linux 2.4.20-wolk4.10s i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_toXUAPTVrsURsTu"
Message-Id: <200403120951.57637@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_toXUAPTVrsURsTu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 11 March 2004 21:23, Adrian Bunk wrote:

Hi Adrian,

> On Wed, Mar 10, 2004 at 11:31:40PM -0800, Andrew Morton wrote:
> >...
> > ext3-journalled-quotas-2.patch
> >   ext3: journalled quota
> >...

> This patch broke modular quota:
>   WARNING: /lib/modules/2.6.4-mm1/kernel/fs/quota_v2.ko needs unknown
>   symbol mark_info_dirty

Patch attached (again) ;)


ciao, Marc

--Boundary-00=_toXUAPTVrsURsTu
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.6.4-mm1-fixups-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.4-mm1-fixups-0.patch"

--- old/fs/dquot.c	2004-03-08 23:49:35.000000000 +0100
+++ new/fs/dquot.c	2004-03-08 23:51:02.000000000 +0100
@@ -1733,3 +1733,4 @@ EXPORT_SYMBOL(dquot_alloc_inode);
 EXPORT_SYMBOL(dquot_free_space);
 EXPORT_SYMBOL(dquot_free_inode);
 EXPORT_SYMBOL(dquot_transfer);
+EXPORT_SYMBOL(mark_info_dirty);

--Boundary-00=_toXUAPTVrsURsTu--
