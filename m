Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272036AbRH2SWZ>; Wed, 29 Aug 2001 14:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272037AbRH2SWP>; Wed, 29 Aug 2001 14:22:15 -0400
Received: from colombina.comedia.it ([213.246.1.10]:22029 "HELO
	colombina.comedia.it") by vger.kernel.org with SMTP
	id <S272036AbRH2SWF>; Wed, 29 Aug 2001 14:22:05 -0400
Date: Wed, 29 Aug 2001 20:22:19 +0200
From: Luca Berra <bluca@comedia.it>
To: lvm-devel@sistina.com
Cc: linux-kernel@vger.kernel.org
Subject: VFS lock and 2.4.9ac
Message-ID: <20010829202219.B6419@colombina.comedia.it>
Reply-To: bluca@comedia.it
Mail-Followup-To: lvm-devel@sistina.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux colombina.comedia.it 2.2.19aa1 i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello, i saw that patch 2.3.9ac moves mount_sem from fs/super.c to
fs/namespace.c (it is devlared static), this has problems
with VFS lock patch that is needed fro LVM snapshots and journaled fs
which uses mount_sem in unlockfs()
I believe the best way to fix this is moving unlockfs()
to fs/namespace.c, but i am not 100% positive
what would you suggest?

L.
(btw i am not on l-k, so please cc replies)

-- 
Luca Berra -- bluca@comedia.it
        Communication Media & Services S.r.l.
 /"\
 \ /     ASCII RIBBON CAMPAIGN
  X        AGAINST HTML MAIL
 / \
