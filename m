Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVBWA3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVBWA3j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 19:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVBWA3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 19:29:39 -0500
Received: from relay.axxeo.de ([213.239.199.237]:20631 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S261362AbVBWA3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 19:29:37 -0500
From: Ingo Oeser <ioe-lkml@axxeo.de>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 4/6] Bind Mount Extensions 0.06
Date: Wed, 23 Feb 2005 01:29:30 +0100
User-Agent: KMail/1.7.1
References: <20050222121233.GE3682@mail.13thfloor.at>
In-Reply-To: <20050222121233.GE3682@mail.13thfloor.at>
Cc: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502230129.30225.ioe-lkml@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Herbert Poetzl wrote:
> +static inline int mnt_may_unlink(struct vfsmount *mnt, struct inode *dir,
> struct dentry *child) { +       if (!child->d_inode)
> +               return -ENOENT;
> +       if (MNT_IS_RDONLY(mnt))
> +               return -EROFS;
> +       return 0;
> +}

The argument "dir" is not used. Please remove it and fix the callers.


Regards

Ingo Oeser

