Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264925AbUA0XmE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 18:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265675AbUA0XkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 18:40:04 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:17334 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S264925AbUA0Xjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 18:39:36 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Christoph Hellwig <hch@infradead.org>
Date: Wed, 28 Jan 2004 10:39:11 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16406.63135.118742.545084@notabene.cse.unsw.edu.au>
Cc: Florian Huber <florian.huber@mnet-online.de>,
       JFS-Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Jfs-discussion] md raid + jfs + jfs_fsck
In-Reply-To: message from Christoph Hellwig on Tuesday January 27
References: <1075230933.11207.84.camel@suprafluid>
	<1075231718.21763.28.camel@shaggy.austin.ibm.com>
	<1075232395.11203.94.camel@suprafluid>
	<1075236185.21763.89.camel@shaggy.austin.ibm.com>
	<20040127205324.A19913@infradead.org>
	<1075238385.14214.3.camel@suprafluid>
	<20040127212243.A20349@infradead.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday January 27, hch@infradead.org wrote:
> 
> You can't partition md devices (yet), but otherwise yes.  I think you can
> also create md device without the persistant superblock still, but it
> always was a pain to maintain those.

non-persistent superblock arrays only work for raid0 and linear
(i.e. not redundancy).  RAID1 and RAID5 need a superblock.

NeilBrown

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
