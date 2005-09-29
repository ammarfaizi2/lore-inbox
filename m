Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbVI2T61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbVI2T61 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbVI2T61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:58:27 -0400
Received: from [205.233.219.253] ([205.233.219.253]:52200 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S964860AbVI2T60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:58:26 -0400
Date: Thu, 29 Sep 2005 15:51:21 -0400
From: Jody McIntyre <scjody@modernduck.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: Fix broken module aliases in ieee1394
Message-ID: <20050929195121.GA8095@conscoop.ottawa.on.ca>
References: <20050929185732.GA31117@redhat.com> <20050929121038.54d4cef0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050929121038.54d4cef0.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 12:10:38PM -0700, Andrew Morton wrote:

> hm.  There are a bunch of 1394 patches in -mm which appear to remove
> most/all of this stuff.

Stefan's patch (attached) just removes those aliases, but that's fine
since they've never worked.

> So what-the-heck I think I'll send those patches on to Linus today.  Please
> review the result and send any remaining fixups on to Linus for 2.6.14. 
> (I'm offline for ~10 days, starting tomorrow).

You could just push that patch.  It applies fine on its own.  It would
be really nice to see the rest of them in 2.6.14 though since they
contain some much-needed sbp2 fixes, among other things.

Jody


Subject: ieee1394: delete legacy module aliases

amdtp, dv1394, raw1394, video1394:
Delete legacy module aliases. The macros did not work and the aliases are not
needed nowadays.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
Signed-off-by: Ben Collins <bcollins@debian.org>
Signed-off-by: Jody McIntyre <scjody@steamballoon.com>

Index: linux-2.6.13/drivers/ieee1394/amdtp.c
===================================================================
--- linux-2.6.13.orig/drivers/ieee1394/amdtp.c
+++ linux-2.6.13/drivers/ieee1394/amdtp.c
@@ -1297,4 +1297,3 @@ static void __exit amdtp_exit_module (vo
 
 module_init(amdtp_init_module);
 module_exit(amdtp_exit_module);
-MODULE_ALIAS_CHARDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_AMDTP * 16);
Index: linux-2.6.13/drivers/ieee1394/dv1394.c
===================================================================
--- linux-2.6.13.orig/drivers/ieee1394/dv1394.c
+++ linux-2.6.13/drivers/ieee1394/dv1394.c
@@ -2660,4 +2660,3 @@ static int __init dv1394_init_module(voi
 
 module_init(dv1394_init_module);
 module_exit(dv1394_exit_module);
-MODULE_ALIAS_CHARDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_DV1394 * 16);
Index: linux-2.6.13/drivers/ieee1394/raw1394.c
===================================================================
--- linux-2.6.13.orig/drivers/ieee1394/raw1394.c
+++ linux-2.6.13/drivers/ieee1394/raw1394.c
@@ -2958,4 +2958,3 @@ static void __exit cleanup_raw1394(void)
 module_init(init_raw1394);
 module_exit(cleanup_raw1394);
 MODULE_LICENSE("GPL");
-MODULE_ALIAS_CHARDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_RAW1394 * 16);
Index: linux-2.6.13/drivers/ieee1394/video1394.c
===================================================================
--- linux-2.6.13.orig/drivers/ieee1394/video1394.c
+++ linux-2.6.13/drivers/ieee1394/video1394.c
@@ -1571,4 +1571,3 @@ static int __init video1394_init_module 
 
 module_init(video1394_init_module);
 module_exit(video1394_exit_module);
-MODULE_ALIAS_CHARDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_VIDEO1394 * 16);
