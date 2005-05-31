Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbVEaBlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVEaBlW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 21:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVEaBlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 21:41:22 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:14523 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261856AbVEaBlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 21:41:20 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: mingo@elte.hu
Subject: RT patch breaks X86_64 build
Date: Mon, 30 May 2005 21:41:31 -0400
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505302141.31731.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

Realtime patch breaks the x86_64 build -

CC      arch/x86_64/kernel/mce.o
In file included from arch/x86_64/kernel/mce.c:17:
include/linux/fs.h: In function `lock_super':
include/linux/fs.h:828: warning: implicit declaration of function `down'
include/linux/fs.h: In function `unlock_super':
include/linux/fs.h:833: warning: implicit declaration of function `up'
arch/x86_64/kernel/mce.c: In function `mce_read':
arch/x86_64/kernel/mce.c:383: warning: type defaults to `int' in declaration 
of `DECLARE_MUTEX'
arch/x86_64/kernel/mce.c:383: warning: parameter names (without types) in 
function declaration
arch/x86_64/kernel/mce.c:392: error: `mce_read_sem' undeclared (first use in 
this function)
arch/x86_64/kernel/mce.c:392: error: (Each undeclared identifier is reported 
only once
arch/x86_64/kernel/mce.c:392: error: for each function it appears in.)
make[1]: *** [arch/x86_64/kernel/mce.o] Error 1
make: *** [arch/x86_64/kernel] Error 2

Parag
