Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310133AbSCFSqd>; Wed, 6 Mar 2002 13:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310138AbSCFSqX>; Wed, 6 Mar 2002 13:46:23 -0500
Received: from w197.z066088144.sjc-ca.dsl.cnc.net ([66.88.144.197]:46526 "EHLO
	kali.zeta-soft.com") by vger.kernel.org with ESMTP
	id <S310133AbSCFSqL>; Wed, 6 Mar 2002 13:46:11 -0500
From: "Scott L. Burson" <gyro@zeta-soft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Wed,  6 Mar 2002 10:47:02 -0800 (PST)
To: linux-kernel@vger.kernel.org
Subject: Performance issue on dual Athlon MP
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <15494.24078.539907.911296@kali.zeta-soft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I have a dual Athlon MP box (Tyan S2460 Tiger MP, 1.53 GHz, 2.5 GB Corsair
PC2100).  The initial installation was of SuSE 7.3, but I have upgraded to
2.4.17 with Andrea's 3.5 GB userspace patch.

Mostly the machine works fine, but when it does a lot of disk I/O, it starts 
to bog down badly.  The most common cause is a large `find', such as those
that SuSE runs periodically over the root filesystem, which has some 22GB of 
stuff in it (it's ReiserFS, BTW).  "Bog down badly" means:

() shell can take several minutes to respond to input

() `top' updates become rare, but when they occur, show both CPUs spending
upwards of 95% of their cycles in the kernel

Although the system can appear hung, if I leave it alone for a few hours, it
recovers and everything is fine.

Is this a known problem with 2.4.17 and/or the 3.5 GB userspace patch?  I
have not tried turning off the 3.5 GB config option (`CONFIG_05GB').  I do
have `CONFIG_MK7' set.

Please CC: me in replies, as I am not on the list.

-- Scott
