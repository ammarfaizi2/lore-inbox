Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131080AbQLGQiY>; Thu, 7 Dec 2000 11:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130887AbQLGQiR>; Thu, 7 Dec 2000 11:38:17 -0500
Received: from d06lmsgate-3.uk.ibm.com ([195.212.29.3]:46822 "EHLO
	d06lmsgate-3.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S130235AbQLGQiF>; Thu, 7 Dec 2000 11:38:05 -0500
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: linux-kernel@vger.kernel.org
Message-ID: <802569AE.00588787.00@d06mta06.portsmouth.uk.ibm.com>
Date: Thu, 7 Dec 2000 16:04:21 +0000
Subject: Why is double_fault serviced by a trap gate?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Why is double_fault serviced by a trap gate? The problem with this is that
any double-fault caused by a stack-fault, which is the usual reason,
becomes a triple-fault. And a triple-fault results in a processor reset or
shutdown making the fault damn near impossible to get any information on.

Oughtn't the double-fault exception handler be serviced by a task gate? And
similarly the NMI handler in case the NMI is on the current stack page
frame?




Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
