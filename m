Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbVKGKke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbVKGKke (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 05:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVKGKke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 05:40:34 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:55277 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751317AbVKGKkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 05:40:33 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 17/25] vfat: move ioctl32 code to fs/fat/dir.c
Date: Mon, 7 Nov 2005 11:42:03 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, hirofumi@mail.parknet.co.jp
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com> <20051105162717.628382000@b551138y.boeblingen.de.ibm.com> <20051107033754.GB15864@lst.de>
In-Reply-To: <20051107033754.GB15864@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200511071142.03862.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maandag 07 November 2005 04:37, Christoph Hellwig wrote:
> > +     set_fs(KERNEL_DS);
> > +     ret = fat_dir_ioctl(file->f_dentry->d_inode, file, cmd, (unsigned long) &d);
> > +     set_fs(oldfs);
> 
> In fact there's even a much better way to implement this, let the
> ioctls call __fat_readdir directly with a filldir callback that directly
> works in compat_dirent structures.

Yes, I'll do that.

	Arnd <><
