Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263472AbUDZUgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbUDZUgd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 16:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263557AbUDZUgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 16:36:33 -0400
Received: from adsl120.freestart.hu ([193.226.240.120]:9480 "EHLO matrix")
	by vger.kernel.org with ESMTP id S263472AbUDZUgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 16:36:31 -0400
Date: Mon, 26 Apr 2004 22:37:10 +0200
To: linux-kernel@vger.kernel.org
Subject: bug in include file!?
Message-ID: <20040426203710.GA3005@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: csg69@mailbox.hu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Kernel Stuff!


I encountered a strange error recently, when I tried to
compile cdrtools-2.00.3 on my system (debian woody 3.0,
kernel 2.6.5, gcc 2.95.4, make 3.79.1).

The bug is in line 217 in /usr/src/linux/include/scsi/scsi.h
gcc says: parse error before u8
(I think everything is OK there)

Finally I solved the problem by changing the value
in cdrtools-2.00.3/DEFAULTS/Defaults.linux

from the original:
DEFINCDIRS=	$(SRCROOT)/include /usr/src/linux/include

to:
DEFINCDIRS=	$(SRCROOT)/include /usr/include


It seems that in /usr/include/scsi/scsi.h everything is OK...


It may be the error of the makefiles or the kernel include files...

Joerg Schilling (schilling@fokus.fraunhofer.de) advised me
to send to you this report.
He thinks this is a bug in kernel include files.


yours sincerely


csg


