Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264551AbTFEJmh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 05:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264554AbTFEJmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 05:42:37 -0400
Received: from h24-87-160-169.vn.shawcable.net ([24.87.160.169]:1412 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id S264551AbTFEJmg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 05:42:36 -0400
Date: Thu, 5 Jun 2003 02:56:06 -0700
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: [2.5.70] ext2 floppy corruption
Message-ID: <20030605095606.GA4415@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.5.70 and 2.5.66 (just tried those two), I see floppy corruption
when I attempt to copy a kernel file to a floppy formatted with ext2. 
Rebooting into 2.4.21rc7 and rerunning the copy seems to cure the
problem.

To reproduce:

mke2fs /dev/fd0
mount /dev/fd0 /a
cp -a /vmlinuz /a
umount /a
mount /a
md5sum /a/vmlinuz /vmlinuz

I get the wrong md5sum consistently from the floppy.  When attempting to
boot this kernel with grub, I get a "attempting to access data outside of
partition" error after it is loading for a little while.

If I mkdosfs on the same floppy and copy over the kernel, it seems to
work properly.

I will try to track this down further if nobody has any immediate ideas.

Simon-

[        Simon Kirby        ][        Network Operations        ]
[     sim@netnation.com     ][     NetNation Communications     ]
[  Opinions expressed are not necessarily those of my employer. ]
