Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266209AbUFYFTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266209AbUFYFTN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 01:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266211AbUFYFTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 01:19:13 -0400
Received: from smtp.polymtl.ca ([132.207.4.11]:17600 "EHLO smtp.polymtl.ca")
	by vger.kernel.org with ESMTP id S266209AbUFYFTL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 01:19:11 -0400
Message-ID: <1088140750.40dbb5ce0fd50@www.imp.polymtl.ca>
Date: Fri, 25 Jun 2004 07:19:10 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@polymtl.ca>
To: linux-kernel@vger.kernel.org
Subject: [Patch] Enhanced Linux System Accounting for 2.6.7
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 192.90.72.1
X-Poly-FromMTA: (c4.si.polymtl.ca [132.207.4.29]) at Fri, 25 Jun 2004 05:19:10 +0000
X-AntiVirus: checked by Vexira Milter 1.0.6; VAE 6.26.0.3; VDF 6.26.0.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

    Here is a new patch for kernel 2.6.7. You can download it from 
sourceforge at 
http://prdownloads.sourceforge.net/elsa/patch-2.6.7-elsa?download
  
    This patch provides structures and functions to do accounting
for a group of process. There is two parts. 

  On one hand there is two APIs that allow the creation and the 
destruction of an item called a "bank" that will contain an 
group of processes. There is also two other routines that can 
add or remove processes in a bank.

  On the other hand, you have the accounting mechanism that used bank
to perform BSD-like accounting for a group of process. We used ioctl()
interface to create/destroy a bank and also to add/remove a process in
a bank. Currently, device driver is dev/elsacct and the major number
is dynamically allocated, therefore you need to check the number in the
/proc/devices and create the corresponding device. A sample code is
given at:
http://cvs.sourceforge.net/viewcvs.py/elsa/tests/elsa_cmd.c?rev=1.7&view=markup
 
    Currently we do BSD-like accounting. The next step is to identify what
kind of metrics can be interesting for accounting. We started to describe
that point on a withpaper that is available at:
http://sourceforge.net/docman/display_doc.php?docid=23446&group_id=105806
This paper describes differences between two accounting systems that are
ELSA and CSA.
 
    Every comments are welcome, 

The ELSA poject team (http://elsa.sourceforge.net)
