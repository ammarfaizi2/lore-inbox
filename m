Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268972AbUHMEpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268972AbUHMEpL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 00:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268970AbUHMEpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 00:45:11 -0400
Received: from web81410.mail.yahoo.com ([206.190.37.99]:53330 "HELO
	web81410.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268972AbUHMEoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 00:44:54 -0400
Message-ID: <20040813044453.23264.qmail@web81410.mail.yahoo.com>
Date: Thu, 12 Aug 2004 21:44:53 -0700 (PDT)
From: Chaoxin Qiu <chaoxin_qiu@sbcglobal.net>
Subject: possible bug with vmalloc
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is to report a problem I encountered for kernel
version 2.4.20-8.  Preliminary search found no direct
pointer to this particular situation.  

System:  Dell Dimension 2400, one 2.4GHz P4, with 1GB
DDR SDRAM (2 512MB DIMM).
OS: Red Hat 9.0 with kernel version 2.4.20-8
Problem:  vmalloc failed to allocate more than 90MB.
Initial debug found the following:

VMALLOC_START=0xF8800000
VMALLOC_END  =0xFDFFE000

It leaves the range in between to about 88MB.

I wonder why VMALLOC_START is so high?

Thanks,
Charles
