Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVCaUxC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVCaUxC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 15:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVCaUxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 15:53:02 -0500
Received: from rev.193.226.232.24.euroweb.hu ([193.226.232.24]:2483 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261387AbVCaUw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 15:52:59 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE: 0/3 update kernel ABI
Message-Id: <E1DH6eg-000167-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 31 Mar 2005 22:52:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following 3 patches change the userspace interface.  Backward
compatibility is not retained, the library must be upgraded to
2.3-pre1 or later.  The library will support both the old and the new
ABI versions.  Filesystems dynamically linked with libfuse don't need
to be recompiled.

The main reason for the change is that the current interface was not
compatible between 32bit and 64bit modes of dual architecures.

The patches are:

  1/3 - Add padding to structures to make sizes the same on 32bit and
        64bit archs

  2/3 - Add offset to fuse_dirent structure.  This will make the
        readdir interface more flexible

  3/3 - Change ABI major version from 5 to 6, and check if userspace
        supports the new interface

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
