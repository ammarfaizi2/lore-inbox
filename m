Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269707AbRHCXmY>; Fri, 3 Aug 2001 19:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269708AbRHCXmO>; Fri, 3 Aug 2001 19:42:14 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22291 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269707AbRHCXmD>; Fri, 3 Aug 2001 19:42:03 -0400
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic change patch)
To: cw@f00f.org (Chris Wedgwood)
Date: Sat, 4 Aug 2001 00:42:38 +0100 (BST)
Cc: viro@math.psu.edu (Alexander Viro),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk (Alan Cox), mason@suse.com (Chris Mason)
In-Reply-To: <20010804113525.E17925@weta.f00f.org> from "Chris Wedgwood" at Aug 04, 2001 11:35:25 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SoaV-0004Et-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For 2.5.x I assume your planning or a credentials cache?  Something
> like dentry->d_creds or something?  If that's the case we still don't
> need the struct file* to be passed --- but I suspect that's not the
> case and I really don't understand.

It can't come off the dentry as multiple people can have the same file open
with different rights.
