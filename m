Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313620AbSDHN26>; Mon, 8 Apr 2002 09:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313621AbSDHN25>; Mon, 8 Apr 2002 09:28:57 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:50439 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S313620AbSDHN24>;
	Mon, 8 Apr 2002 09:28:56 -0400
Date: Mon, 08 Apr 2002 22:29:06 +0900 (JST)
Message-Id: <20020408.222906.10292799.taka@valinux.co.jp>
To: nfs@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [NFS][PATCH] zerocopy NFS
From: Hirokazu Takahashi <taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I'm tuning knfsd and I implemented zerocopy knfsd.
Everyone knows knfsd copies file data many times,
so I tried to reduce the copies. 
nfsd_read() doesn't copy filedata anymore.
This works pretty fine and performance is improved.

Following patches patches are against linux 2.5.7

ftp:/ftp.valinux.co.jp/pub/people/taka/tune/2.5.7/va01-knfsd-zerocopy-vfsread-2.5.7.patch
ftp:/ftp.valinux.co.jp/pub/people/taka/tune/2.5.7/va02-kmap-multplepages-2.5.7.patch

I also have patches against linux 2.4.18

ftp:/ftp.valinux.co.jp/pub/people/taka/tune/2.4.18/va01-knfsd-zerocopy-vfsread-2.4.18.patch
ftp:/ftp.valinux.co.jp/pub/people/taka/tune/2.4.18/va02-kmap-multplepages-2.4.18.patch


Now I'm designing new mechanism to send pagecache directly 
using sendpage.

I'm waiting for your comments.


Regards,
Hirokazu Takahashi
VP Engineering Dept.
VA Linux Systems Japan
