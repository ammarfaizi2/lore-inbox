Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261872AbSKMO4x>; Wed, 13 Nov 2002 09:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbSKMO4w>; Wed, 13 Nov 2002 09:56:52 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:7177 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S261872AbSKMO4v>; Wed, 13 Nov 2002 09:56:51 -0500
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VFAT mount (bug or feature?)
References: <20021113014704.780a3e4a.us15@os.inf.tu-dresden.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 14 Nov 2002 00:03:25 +0900
In-Reply-To: <20021113014704.780a3e4a.us15@os.inf.tu-dresden.de>
Message-ID: <874ralldfm.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Udo A. Steinberg" <us15@os.inf.tu-dresden.de> writes:

> Hello,
> 
> In my /etc/fstab I have the following entry:
> 
> /dev/hda1  /win   vfat   defaults,umask=022  1 1
> 
> Why does 2.5.47 have user/group restricted permissions on the mount
> point and all its subdirectories, despite the umask setting?

The dmask option was added at 2.5.43. It's umask for directory, and
default is umask of process when mounting.  Please use it.

eg.
    # mount -t vfat /dev/xxx /xxx -o dmask=022

Regards
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
