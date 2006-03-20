Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWCTMVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWCTMVi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 07:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWCTMVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 07:21:38 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:29648 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932248AbWCTMVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 07:21:37 -0500
Message-ID: <07fa01c64c18$d3ac7a60$4168010a@bsd.tnes.nec.co.jp>
From: "Takashi Sato" <sho@bsd.tnes.nec.co.jp>
To: "Andreas Dilger" <adilger@clusterfs.com>
Cc: <linux-kernel@vger.kernel.org>, <ext2-devel@lists.sourceforge.net>
References: <20060318220130sho@rifu.tnes.nec.co.jp> <20060320072037.GD30801@schatzie.adilger.int>
Subject: Re: [Ext2-devel] [PATCH 1/4] ext2/3: Extends the max file size(ext2 in kernel)
Date: Mon, 20 Mar 2006 21:21:29 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

> Instead of breaking all filesystems that need to create large files,
> the patch should instead set "i_flags | EXT2_LARGEBLK_FL" only on inodes
> that are larger than 2TB and use "blocksize" i_blocks on those files.

Do you have any idea when the flag is set and cleared?
 
> This preserves compatibility with existing filesystems and doesn't
> impose any breakage opon an existing filesystem for anyone who wants
> to use this feature.

I'm afraid that i_blocks of >2TB file would be corrupted if old kernel
or old e2fsprogs touches the file.

--
Takashi Sato
