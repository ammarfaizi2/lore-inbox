Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262314AbSK0Lkk>; Wed, 27 Nov 2002 06:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262317AbSK0Lkk>; Wed, 27 Nov 2002 06:40:40 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:57064 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S262314AbSK0Lkj>; Wed, 27 Nov 2002 06:40:39 -0500
Date: Wed, 27 Nov 2002 12:47:47 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: patch: 2.5.49+bk(-ac1,-ac2) missing interrupt.h sound/oss/sb_ess.c
Message-ID: <20021127114747.GD27097@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the warning of implicit declaration of free_irq go.

  CC [M]  sound/oss/sb_ess.o
sound/oss/sb_ess.c: In function `ess_dsp_init':
sound/oss/sb_ess.c:1341: warning: implicit declaration of function `free_irq'


--- 2.5/sound/oss/sb_ess.c	2002-07-31 19:09:34.000000000 +0200
+++ 2.5c/sound/oss/sb_ess.c	2002-11-27 12:37:39.000000000 +0100
@@ -187,6 +187,7 @@
 
 #include <linux/delay.h>
 #include <linux/spinlock.h>
+#include <linux/interrupt.h>
 
 #include "sound_config.h"
 #include "sb_mixer.h"

