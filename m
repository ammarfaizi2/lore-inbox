Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275085AbTHSQaQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 12:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S276357AbTHSQaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 12:30:07 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:386 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S276348AbTHSQ3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 12:29:21 -0400
Date: Tue, 19 Aug 2003 09:28:47 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: iansu@optushome.com.au
Subject: [Bug 1126] New: tgafb.c doesn't compile on alpha 
Message-ID: <15870000.1061310527@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1126

           Summary: tgafb.c doesn't compile on alpha
    Kernel Version: 2.5.75
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: iansu@optushome.com.au


Distribution: debian
Hardware Environment: alpha multia (noname)
Problem Description: 

tgafb.c required these changes to compile for me, when not compiling as a module.

*** tgafb.c.bak Wed Aug 20 01:56:56 2003
--- tgafb.c     Wed Aug 20 01:43:09 2003
***************
*** 23,28 ****
--- 23,29 ----
  #include <linux/init.h>
  #include <linux/fb.h>
  #include <linux/pci.h>
+ #include <linux/selection.h>
  #include <asm/io.h>
  #include <video/tgafb.h>
  
***************
*** 80,86 ****
--- 81,89 ----
        .name                   = "tgafb",
        .id_table               = tgafb_pci_table,
        .probe                  = tgafb_pci_register,
+ #ifdef MODULE
        .remove                 = __devexit_p(tgafb_pci_unregister),
+ #endif
  };

