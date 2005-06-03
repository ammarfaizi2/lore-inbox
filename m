Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVFCOw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVFCOw4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 10:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVFCOw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 10:52:56 -0400
Received: from dvhart.com ([64.146.134.43]:27559 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261307AbVFCOwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 10:52:54 -0400
Date: Fri, 03 Jun 2005 07:52:49 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: ppc64 dev list <linuxppc64-dev@ozlabs.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.12-rc5-git8 regression on PPC64
Message-ID: <374360000.1117810369@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-git7 seems to boot fine, but -git8 is broken. See here:

http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/4547/debug/console.log

for full boot log, but basically it does this:

DEFAULT CATCH!, handler-entered=fff00300 
Open Firmware exception handler entered from non-OF code

Client's Fix Pt Regs:
 00 0000000000000003 000000000291f800 00000000040acb88 0000000000000010
 04 0000000024004042 0000000000000000 0000000000000000 0000000000000000
 08 0000000000000000 000000077f800000 0000000000100000 0000000000000001
 0c 2000000000000000 0000000000000000 0000000000000000 0000000000000000
 10 0000000000000000 0000000000000000 0000000000000000 0000000000000000
 14 0000000000230000 0000000780000000 0000000003a10000 0000000003ef2300
 18 000000000291fa24 bffffffffc5f0000 000000077f800000 0000000003ef2478
 1c bffffffffc5f0000 000000000291fa30 000000000291fab0 000000000291faf4
Special Regs:
    %IV: 00000300     %CR: 84004044    %XER: 00000000  %DSISR: 0a000000 
  %SRR0: 0000000003ec6644   %SRR1: 8000000000003000 
    %LR: 0000000003ec661c    %CTR: 0000000000000000 
   %DAR: 000000077f800000 
PID = 0 

 ofdbg

Which doesn't give me anything useful, but perhaps it does for you ;-)

M.

