Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbTDJOJV (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 10:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264047AbTDJOJV (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 10:09:21 -0400
Received: from pointblue.com.pl ([62.89.73.6]:7172 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S264045AbTDJOJT (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 10:09:19 -0400
Subject: ATAPI cdrecord issue 2.5.67
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-2
Organization: K4 Labs
Message-Id: <1049983308.888.5.camel@gregs>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 10 Apr 2003 15:01:48 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed strange bahavior while truing to record CD using ATAPI on
2.5.67 kernel:

bash-2.05b$ cdrecord -scanbus dev=ATAPI
Cdrecord 2.01a07 (i686-pc-linux-gnu) Copyright (C) 1995-2003 Jörg
Schilling
scsidev: 'ATAPI'
devname: 'ATAPI'
scsibus: -2 target: -2 lun: -2
Warning: Using ATA Packet interface.
Warning: The related libscg interface code is in pre alpha.
Warning: There may be fatal problems.
Using libscg version 'schily-0.7'
scsibus0:
        0,0,0     0) *
        0,1,0     1) 'ADAPTEC ' 'ACB-5500        ' 'FAKE' NON CCS Disk
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *

Well, FAKE non CCS disk ?
i have on this port Sony CDRW :

bash-2.05b$ cat /proc/ide/hdd/model
SONY CD-RW CRX215E1


2.4.21-pre7 still is able to see this drive and i can record CDs on it.
2.5.67 failes.

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 Labs

