Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317604AbSGUAc1>; Sat, 20 Jul 2002 20:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317605AbSGUAc1>; Sat, 20 Jul 2002 20:32:27 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:30732 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S317604AbSGUAc1>; Sat, 20 Jul 2002 20:32:27 -0400
Subject: Re: 2.5.27 -- memory.c:50:22: asm/rmap.h: No such file or directory
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1027211240.1864.24.camel@localhost.localdomain>
References: <1027211240.1864.24.camel@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1027211680.1863.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 20 Jul 2002 20:34:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm.  This problem looks pretty straightforward.

find . -name "*.h" | xargs grep rmap.h

./include/asm-generic/rmap.h: * linux/include/asm-generic/rmap.h
./include/asm-i386/rmap.h:#include <asm-generic/rmap.h>

find . -name "*.c" | xargs grep rmap.h

./mm/memory.c:#include <asm/rmap.h>
./mm/rmap.c:#include <asm/rmap.h>



