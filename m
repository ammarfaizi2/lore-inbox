Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276116AbRJBS3a>; Tue, 2 Oct 2001 14:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276120AbRJBS3V>; Tue, 2 Oct 2001 14:29:21 -0400
Received: from cabal.xs4all.nl ([213.84.101.140]:52945 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S276116AbRJBS3H>;
	Tue, 2 Oct 2001 14:29:07 -0400
Date: Tue, 2 Oct 2001 20:29:34 +0200
From: Wichert Akkerman <wichert@cistron.nl>
To: linux-kernel@vger.kernel.org, linux-lvm@sistina.com
Subject: partition table read incorrectly
Message-ID: <20011002202934.G14582@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-lvm@sistina.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I seem to run into a weird problem. LVM refused to work properly,
after a "vgscan" command "vgchange -a y" would still complain
that things weren't consistent and I got a messages about an
I/O error on 08:11.

Interestingly my sdb does not have any partitions since it's one
big PV, and fdisk agrees with me on that. However the kernel
seems to thing I do have a partition there and as a result LVM
seems to get somewhat confused.

This happens with both 2.4.9-ac17 and 2.4.10-ac3. If anyone has
any ideas on how to go about fixing this don't hestitate to ask
me for more details.

Wichert.

-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@wiggy.net                   http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |
