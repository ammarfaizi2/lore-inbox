Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263499AbTICOh3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 10:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263505AbTICOh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 10:37:28 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:39130 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263499AbTICOh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 10:37:27 -0400
Date: Wed, 03 Sep 2003 07:36:55 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: len.brown@intel.com
Subject: [Bug 1177] New: print_IO_APIC() is too early in ACPI mode
Message-ID: <20720000.1062599815@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: print_IO_APIC() is too early in ACPI mode
    Kernel Version: 2.6.0-test4
            Status: NEW
          Severity: normal
             Owner: len.brown@intel.com
         Submitter: len.brown@intel.com
                CC: linux-acpi@intel.com


setup_IO_APIC() doesn't know that ACPI is (later) programming the IO-APICs, 
so it calls print_IO_APIC() and dumps the hardware state before the hardware is programmed. 
 
This output is at best useless, and at worst confusing. 
If this output is to appear when booting with ACPI, it should occur once -- after ACPI has 
programmed the APICs.


