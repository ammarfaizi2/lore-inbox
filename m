Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279754AbRKFQUe>; Tue, 6 Nov 2001 11:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279717AbRKFQUY>; Tue, 6 Nov 2001 11:20:24 -0500
Received: from pf107.gdansk.sdi.tpnet.pl ([213.77.129.107]:10500 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S279778AbRKFQUO>; Tue, 6 Nov 2001 11:20:14 -0500
Subject: deactivate_page in loop.c, min/max in isofs/compress.c
To: torvalds@transmeta.com
Date: Tue, 6 Nov 2001 17:19:47 +0100 (CET)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL94 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E1618x1-0002f8-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've just compiled 2.4.14 (with the latest lm-sensors and ext3 patches,
but that shouldn't matter) and it seems to work well so far, except:

 - drivers/block/loop.c has two deactivate_page() calls, and that
   function no longer exists, so the final link fails (I simply
   removed these calls, is that OK?)

 - fs/isofs/compress.c gives two gcc warnings about redefining
   these evil min/max macros :)

Thanks, and keep up the good work!
Marek

