Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264760AbSLVFYK>; Sun, 22 Dec 2002 00:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264767AbSLVFYK>; Sun, 22 Dec 2002 00:24:10 -0500
Received: from smtp.comcast.net ([24.153.64.2]:1331 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S264760AbSLVFYJ>;
	Sun, 22 Dec 2002 00:24:09 -0500
Date: Sun, 22 Dec 2002 00:36:32 -0500
From: Joshua Stewart <joshua.stewart@comcast.net>
Subject: A little explanation needed
To: linux-kernel@vger.kernel.org
Message-id: <1040535392.1518.3.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10)
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can anyone explain the purpose of this #define...

#define __cpu_raise_softirq(cpu, nr) do { softirq_pending(cpu) |= 1UL <<
(nr); } while (0)    // from interrupt.h

...versus the more "plain"...


#define __cpu_raise_softirq(cpu,nr) softirq_pending(cpu |= 1UL << (nr).

In otherwords, what's the use of a do{X}while(0) "loop" instead of just
X.  I'm not the world's best trained C programmer, so forgive me if I
sound stupid.

Josh


