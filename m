Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbULBHze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbULBHze (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 02:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbULBHze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 02:55:34 -0500
Received: from [61.48.53.101] ([61.48.53.101]:21481 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261177AbULBHzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 02:55:31 -0500
Date: Wed, 1 Dec 2004 23:45:56 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200412020745.iB27juw26826@adam.yggdrasil.com>
To: chrisw@osdl.org
Subject: Re: [Patch?] Teach sysfs_get_name not to use a dentry
Cc: akpm@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       maneesh@in.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
>the kobject is available as sysfs_dirent->s_dentry->d_parent->s_fsdata.

Argh.  I meant the attribute group's kobject is available as

((struct sysfs_dirent *) sysfs_dirent->s_dentry->d_parent->s_fsdata)->s_element

	...although this is normally calculated with some intermediate
steps and variables for clarity.

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
