Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935568AbWK1E6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935568AbWK1E6k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 23:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935594AbWK1E6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 23:58:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28101 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S935568AbWK1E6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 23:58:39 -0500
Date: Mon, 27 Nov 2006 23:58:11 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: add missing libsas include to fix s390 compilation.
Message-ID: <20061128045811.GB28516@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/scsi/libsas.h:479: error: field 'smp_req' has incomplete type
include/scsi/libsas.h:480: error: field 'smp_resp' has incomplete type

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/include/scsi/libsas.h~	2006-11-27 23:23:32.000000000 -0500
+++ linux-2.6/include/scsi/libsas.h	2006-11-27 23:23:39.000000000 -0500
@@ -35,6 +35,7 @@
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_transport_sas.h>
+#include <asm/scatterlist.h>
 
 struct block_device;
 

-- 
http://www.codemonkey.org.uk
