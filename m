Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263773AbTEFOrO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTEFOrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 10:47:14 -0400
Received: from franka.aracnet.com ([216.99.193.44]:62112 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263773AbTEFOrN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 10:47:13 -0400
Date: Tue, 06 May 2003 07:59:11 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 666] New: machine check handler can deadlock 
Message-ID: <12510000.1052233151@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=666

           Summary: machine check handler can deadlock
    Kernel Version: all 2.4, 2.5
            Status: NEW
          Severity: normal
             Owner: mbligh@aracnet.com
         Submitter: ak@suse.de


The machine check handler calls printk but does not honour cli/sti. When an MCE
happens inside a critical section of printk it'll deadlock.

(bug is in x86-64 too, probably other platforms)


