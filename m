Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265265AbSJaSXr>; Thu, 31 Oct 2002 13:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265260AbSJaSXi>; Thu, 31 Oct 2002 13:23:38 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:31622 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265244AbSJaSXC>; Thu, 31 Oct 2002 13:23:02 -0500
Subject: Nasty changes in SCSI driver code
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-scsi@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 31 Oct 2002 18:49:34 +0000
Message-Id: <1036090174.8584.88.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will whoever committed code that simply deleted the error handling from
ncr53c8xxx, sym53c8xx and inia100 please put it back or at least add a 

#warning "Don't use this driver"

SCSI with no error handling is asking for corruption and not warning
users about this as we try and stabilize the kernel is a very very bad
idea. If it warns or doesnt compile then it can get fixed properly. If
it doesnt warn it may get missed with catastrophic results



