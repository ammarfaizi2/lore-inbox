Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbUK3PmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbUK3PmG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 10:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbUK3PmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 10:42:06 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:59824 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id S262105AbUK3Pls convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 10:41:48 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Walking all the physical memory in an x86 system
Date: Tue, 30 Nov 2004 08:41:17 -0700
Message-ID: <C863B68032DED14E8EBA9F71EB8FE4C2057CA887@azsmsx406>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Walking all the physical memory in an x86 system
Thread-Index: AcTW8wePkeYwDWpuTemZEBYnSPuOLA==
From: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Nov 2004 15:41:18.0334 (UTC) FILETIME=[08A059E0:01C4D6F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I've written a 2.4 kernel module where I'm trying to walk and
record all of the physical memory contents in an x86 system. I have the
following code fragment that does it but I suspect I'm missing a portion
of the memory:

unsigned long memory_address = PAGE_OFFSET;
struct sysinfo RC_sys_info;

si_meminfo(&RC_sys_info);

while (__pa(memory_address) < RC_sys_info.totalram * PAGE_SIZE)
{
	/* Read and record memory contents here. */
	memory_address += 4;
}

Is there a better way to record all of the contents of physical memory
since what I have above doesn't seem to get everything?

