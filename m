Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272741AbTHPLOd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 07:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272757AbTHPLOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 07:14:32 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:14814 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S272741AbTHPLOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 07:14:31 -0400
Subject: syscall clash: mknod64 / fadvise64_64
From: Christophe Saout <christophe@saout.de>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au, torvalds@osdl.org
Content-Type: text/plain
Message-Id: <1061032468.4198.2.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 16 Aug 2003 13:14:28 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I just updated the sources via bkcvs and got the following clash with
the mknod64 patch from Andrews's -mm tree:

include/asm/unistd.h

#define __NR_tgkill     270
#define __NR_utimes     271
<<<<<<< unistd.h
#define __NR_mknod64    272
=======
#define __NR_fadvise64_64  272
>>>>>>> 1.32
                                                                                
#define NR_syscalls 273

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

