Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318614AbSH1DV7>; Tue, 27 Aug 2002 23:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318622AbSH1DV7>; Tue, 27 Aug 2002 23:21:59 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:38082 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S318614AbSH1DV6>; Tue, 27 Aug 2002 23:21:58 -0400
Message-ID: <3D6C431E.4090709@snapgear.com>
Date: Wed, 28 Aug 2002 13:27:26 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: (resend) tivial mtdblock.c fix
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Trivial fixup to mtdblock.c. The logical sense of the command check
is wrong. Against 2.5.32.

Regards
Greg


  ------------------------------------------------------------------------
--- drivers/mtd/mtdblock.c.org	Wed Aug 28 13:09:33 2002
+++ drivers/mtd/mtdblock.c	Wed Aug 28 13:10:40 2002
@@ -406,7 +406,7 @@
  		if (minor(req->rq_dev) >= MAX_MTD_DEVICES)
  			panic(__FUNCTION__": minor out of bound");

-		if (req->flags & REQ_CMD)
+		if (! (req->flags & REQ_CMD))
  			goto end_req;

  		if ((req->sector + req->current_nr_sectors) > (mtdblk->mtd->size >> 9))

------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

