Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314086AbSDLOqO>; Fri, 12 Apr 2002 10:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314097AbSDLOqN>; Fri, 12 Apr 2002 10:46:13 -0400
Received: from albatross-ext.wise.edt.ericsson.se ([193.180.251.49]:13444 "EHLO
	albatross.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id <S314086AbSDLOqN>; Fri, 12 Apr 2002 10:46:13 -0400
Message-ID: <3CB6F332.18225BA4@uab.ericsson.se>
Date: Fri, 12 Apr 2002 16:46:10 +0200
From: Sverker Wiberg <Sverker.Wiberg@uab.ericsson.se>
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Multiple zlib.c's in 2.4.18
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doing

 $ find . -name 'zlib.c'

on the Linux 2.4.18 source reveals the three zlibs

  ./fs/jffs2/zlib.c
  ./drivers/net/zlib.c
  ./arch/ppc/boot/lib/zlib.c

Further checking reveals that ./arch/ppc/boot/lib/zlib.c is based on
zlib-0.95, while the other two are zlib-1.0.4.

Which one should I use? Shouldn't they be merged? And what about the
double-free() bug?

/Sverker
