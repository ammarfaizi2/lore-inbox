Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTFITnc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 15:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbTFITnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 15:43:32 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:32663 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261180AbTFITnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 15:43:31 -0400
Date: Mon, 09 Jun 2003 12:46:03 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 793] New: Thinkpad T30, new BIOS, and ACPI 
Message-ID: <56010000.1055187963@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=793

           Summary: Thinkpad T30, new BIOS, and ACPI
    Kernel Version: 2.5.70-mm6
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: peter@peterjohanson.com


Distribution: gentoo
Hardware Environment: T30 with BIOS v2.04 and EC v1.03
Software Environment:
Problem Description: I recently upgraded the BIOS and embedded controller on my
thinkpad T30 to the latest released by IBM. This has fixed the invalid ECDT
table, which had forced me to use the small patch from 
http://www.poupinou.org/acpi/ibm_ecdt.html
to get ACPI working. Now the table passes the test, and a lot of the ACPI stuff
works. the problem is now when i close and re-open the lid on my laptop. the
system turns nearly unresponsive, and dmesg shows a *ton* of lines:

 ACPI-0295: *** Error: AE_TIME while evaluating method [_L18] for GPE[ 0]
    ACPI-0345: *** Error: Handler for [EmbeddedControl] returned AE_TIME
    ACPI-1121: *** Error: Method execution failed [\_GPE._L18] (Node c1ae74c0), 
AE_TIME
    ACPI-0295: *** Error: AE_TIME while evaluating method [_L18] for GPE[ 0]
    ACPI-0345: *** Error: Handler for [EmbeddedControl] returned AE_TIME
    ACPI-1121: *** Error: Method execution failed [\_GPE._L18] (Node c1ae74c0), 
AE_TIME

and top shows events/0 taking about 10% of the CPU. i will attach my dmesg
output from the system before closing the lid.

Steps to reproduce: close lid  & reopen it.

