Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265601AbSKAEcH>; Thu, 31 Oct 2002 23:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265603AbSKAEcH>; Thu, 31 Oct 2002 23:32:07 -0500
Received: from relay.sotline.ru ([80.89.139.226]:36358 "EHLO relay.sotline.ru")
	by vger.kernel.org with ESMTP id <S265601AbSKAEcG>;
	Thu, 31 Oct 2002 23:32:06 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Anton Petrusevich <casus@att-ltd.biz>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre11: is there something wrong with memory accounting?
Date: Fri, 1 Nov 2002 10:38:13 +0600
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200211011038.13877.casus@att-ltd.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

Look there:
 10:45:38 up 1 day,  1:40,  2 users,  load average: 171.04, 128.12, 79.67
             total       used       free     shared    buffers     cached
Mem:        508388     505556       2832          0        580      10492
-/+ buffers/cache:     494484      13904
Swap:       996020     379696     616324
ps axl|sort -n -r +6|head -n 1
040    33  6918 20448   9   0 589505315 589505315 nanosl SL ?   0:00 [spng]

As you can see, the server has only 512Mb ram and one of processes ate 589Mb 
of RSS. How could it be? A minute ago, "free" output was basically the same, 
the same amount of swap was eatten, but without such a process. I see that 
behaviour quite regularly. Any thoughts?
-- 
Anton Petrusevich
