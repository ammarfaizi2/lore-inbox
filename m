Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274376AbRITJAC>; Thu, 20 Sep 2001 05:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274386AbRITI7w>; Thu, 20 Sep 2001 04:59:52 -0400
Received: from lxxxvii.yapay.inka.de ([212.227.14.215]:61189 "EHLO emil.home")
	by vger.kernel.org with ESMTP id <S274376AbRITI7n>;
	Thu, 20 Sep 2001 04:59:43 -0400
Message-ID: <3BA9A0D9.E111CC70@inka.de>
Date: Thu, 20 Sep 2001 09:55:05 +0200
From: Markus Kossmann <markus.kossmann@inka.de>
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.9-4GB-SMP i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.10-pre12 breaks compiling drivers/atm/firestream.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch-2.4.10-pre12 contains the following hunk, which removes the label
err_out_free_fs_dev without removing the goto jumping to it :

@@ -1928,8 +1928,6 @@
 
  err_out_free_atm_dev:
        atm_dev_deregister(atm_dev);
- err_out_free_fs_dev:
-       kfree(fs_dev);
  err_out:
        return -ENODEV;
 }

-- 
Markus Kossmann                                    
markus.kossmann@inka.de
