Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267598AbUHJSqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267598AbUHJSqo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 14:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267487AbUHJSoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 14:44:08 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:42841 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267519AbUHJSiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 14:38:18 -0400
Message-ID: <9dda3492040810113844ce9174@mail.gmail.com>
Date: Tue, 10 Aug 2004 14:38:13 -0400
From: Diffie <diffie@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.8-rc4-mm1
Cc: LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This is a cosmetic change to the IT8212 RAID driver.

when compiling it prints:

CC drivers/scsi/iteraid.o
In file included from drivers/scsi/iteraid.c:260:
drivers/scsi/hosts.h:1:2: warning: #warning "This file is obsolete,
please use <scsi/scsi_host.h> instead"

Patch below:

diffstat output:
 iteraid.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- drivers/scsi/iteraid.c-orig  2004-08-10 14:30:54.000000000 -0400
+++ drivers/scsi/iteraid.c 2004-08-10 14:31:58.000000000 -0400
@@ -257,7 +257,7 @@
 #include <asm/uaccess.h>

 #include "scsi.h"
-#include "hosts.h"
+#include <scsi/scsi_host.h>

 #include "iteraid.h"
 MODULE_LICENSE("GPL");

Cheers,

Paul
-- 
FreeBSD the Power to Serve!
