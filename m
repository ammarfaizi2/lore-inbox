Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965218AbVINOca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965218AbVINOca (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 10:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965216AbVINOc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 10:32:29 -0400
Received: from dvhart.com ([64.146.134.43]:22147 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S965210AbVINOc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 10:32:28 -0400
Date: Wed, 14 Sep 2005 07:32:29 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: 2.6.13-mm3 and 2.6.14-rc1 both broken (SCSI?)
Message-ID: <319880000.1126708349@[10.10.2.4]>
In-Reply-To: <20050728025840.0596b9cb.akpm@osdl.org>
References: <20050728025840.0596b9cb.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heh, when I said "wheeeeeee - it all works" (with flip fixes) ... 
I spoke too soon.

It's now broken in both -mm3 and -git 
Some scsi problem on one of hte power boxes:

http://test.kernel.org/12729/debug/console.log

Attached scsi disk sdb at scsi0, channel 0, id 9, lun 0
 target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
 target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
 target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
sdc: Spinning up disk....<6> target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
 target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
 target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
 target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
 target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
 target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
 target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
 target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
 target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
 target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
 target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)

( ... repeated forever)

2.6.13-git11 worked.

