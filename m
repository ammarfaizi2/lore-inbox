Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266696AbRGOQqS>; Sun, 15 Jul 2001 12:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266698AbRGOQqI>; Sun, 15 Jul 2001 12:46:08 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28435 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266696AbRGOQpr>; Sun, 15 Jul 2001 12:45:47 -0400
Subject: Re: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
To: reiser@namesys.com (Hans Reiser)
Date: Sun, 15 Jul 2001 17:46:37 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), volodya@mindspring.com,
        ajschrotenboer@lycosmail.com (Adam Schrotenboer),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <3B51C864.C98B61DE@namesys.com> from "Hans Reiser" at Jul 15, 2001 08:44:20 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Lp2T-0004DQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Ext2 handles files larger than 2Gb, and can handle up to about 1Tb per volume
> > which is the block layer fs size limit.
> > 
> The limits for reiserfs and ext2 for kernels 2.4.x are the same (and they are 2Tb not 1Tb).  The
> limits are not in the individual filesystems.  We need to have Linux go to 64 bit blocknumbers in

Its 1 terabyte - there are some unclean sign bit abuses

> 2.5.x, I am seeing a lot of customer demand for it.  (Or we could use scalable integers, which would
> be better.)

We definitely need larger than 1Tb on 2.5.x. No argument there. I believe Ben
had some prototype code for that.

