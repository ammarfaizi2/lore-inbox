Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264983AbSLLSOB>; Thu, 12 Dec 2002 13:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265019AbSLLSMR>; Thu, 12 Dec 2002 13:12:17 -0500
Received: from [195.212.29.5] ([195.212.29.5]:62665 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S264983AbSLLSHk> convert rfc822-to-8bit; Thu, 12 Dec 2002 13:07:40 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390: latest and greates for 2.5.51.
Date: Thu, 12 Dec 2002 19:12:09 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212121905.20679.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
some small s390 patches for 2.5.51. 

The patch overview:

01: Makefile changes as proposed by Sam Ravnborg.
02: sys_restart_syscall for s390/s390x. Following your suggestion I used
    a thread flag (TIF_RESTART_SVC) to indicate the restart condition
    to entry.S.
03: Fixes for the common i/o layer. Among other things I found the race
    condition in do_IRQ that has been plagueing me the last few days.
04: Another uaccess bug. __put_user_asm_8 doesn't return 0 for success.
05: Remove last remaining file of the old tape driver.
06: Arnd scanned through the device drivers and found some variables/functions
    that should better be declared static.
07: Some warnings fixes.
08: Make sys_wait4 available to modules.

blue skies,
  Martin.


