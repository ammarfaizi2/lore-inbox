Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261304AbRELS3C>; Sat, 12 May 2001 14:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261308AbRELS2v>; Sat, 12 May 2001 14:28:51 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:60421 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261304AbRELS2o>; Sat, 12 May 2001 14:28:44 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105121834.UAA15115@green.mif.pg.gda.pl>
Subject: [BUG] loop device problem in 2.2
To: linux-kernel@vger.kernel.org (kernel list)
Date: Sat, 12 May 2001 20:34:21 +0200 (CEST)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  I observe a problem with loop block device over a sparse file grater than
2GB on alpha. When write attempts to the device appear (probably only at
offset greater than 2GB), the filesysstem where the loop device file is
located gets corruptted. i observe this eg. while doing

mke2fs /dev/loop0

I think it is either loop or ext2 problem...

Up till now I have tested 2.2.20pre2 and 2.2.19 kernels.

1. Is this a known problem ?
2. If so, is there any way to fix it ?

Andrzej

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
