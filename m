Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVFEN64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVFEN64 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 09:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVFEN64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 09:58:56 -0400
Received: from mail.linicks.net ([217.204.244.146]:23303 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261567AbVFEN6w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 09:58:52 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: CPU type .config <-> i386/Makefile question[s]
Date: Sun, 5 Jun 2005 14:58:50 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200506051458.50307.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I am still a n00b here learning, so by all means tell me to get lost if what I 
am about to say is total bollocks...

I was just running through building the new 2.4.31 kernel on my Quake2 box, 
with looking at building this time with a few optimisations.

I noticed that arch/i386/Makefile uses generic -march= options.

I can have either Pentium-MMX or PentiumPro - But not Pentium2?

>From GCC 3.4.x docs:

pentium-mmx
Intel PentiumMMX CPU based on Pentium core with MMX instruction set support. 

i686, pentiumpro
Intel PentiumPro CPU. 

pentium2
Intel Pentium2 CPU based on PentiumPro core with MMX instruction set support. 

from i386/Makefile:

ifdef CONFIG_M586MMX
CFLAGS += -march=i586
endif

ifdef CONFIG_M686
CFLAGS += -march=i686
endif

ifdef CONFIG_MPENTIUMIII
CFLAGS += -march=i686
endif


Is there a specific reason why the flags aren't -march=pentium2, pentiumpro 
etc?

Also I notice that if I changed the top level Makefile to include my specific 
CPU, then the i386/Makefile adds += -march=i686 to the build lines AFTER 
CFLAGS~ thus the second one will take precedence (I guess) anyway, and the 
-march CFLAG changes are basically over-ridden?

Regards,

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
