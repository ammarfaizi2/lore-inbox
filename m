Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312316AbSDJKFt>; Wed, 10 Apr 2002 06:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312354AbSDJKFs>; Wed, 10 Apr 2002 06:05:48 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:16395 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S312316AbSDJKFr>;
	Wed, 10 Apr 2002 06:05:47 -0400
Date: Wed, 10 Apr 2002 19:05:50 +0900 (JST)
Message-Id: <20020410.190550.83626375.taka@valinux.co.jp>
To: nfs@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] zerocopy NFS updated
From: Hirokazu Takahashi <taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I add a new patch for zerocopy NFS.
va03-knfsd-zerocopy-sendpage-2.5.7-test1.patch makes knfsd to skip
csum_partial_copy_generic() which copies data into a sk_buff.
This feature works on when you use NFS over TCP only at this moment.
I'd like to implement sendpage for UDP, but it doesn't work yet.

But I wonder about sendpage. I guess HW IP checksum for outgoing
pages might be miscalculated as VFS can update them anytime.
New feature like COW pagecache should be added to VM and they 
should be duplicated in this case.

Is there anyone who could advise me about this.


Following patches patches are against linux 2.5.7

ftp://ftp.valinux.co.jp/pub/people/taka/tune/2.5.7/va01-knfsd-zerocopy-vfsread-2.5.7.patch
ftp://ftp.valinux.co.jp/pub/people/taka/tune/2.5.7/va02-kmap-multplepages-2.5.7.patch

ftp://ftp.valinux.co.jp/pub/people/taka/tune/2.5.7/va03-knfsd-zerocopy-sendpage-2.5.7-test1.patch


Andrew,  Could you try it again?


Regards,
Hirokazu Takahashi
