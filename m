Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbULHRoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbULHRoP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 12:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbULHRoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 12:44:15 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:63097 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id S261272AbULHRoL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 12:44:11 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Figuring out physical memory regions from a kernel module
Date: Wed, 8 Dec 2004 10:44:09 -0700
Message-ID: <C863B68032DED14E8EBA9F71EB8FE4C20596010F@azsmsx406>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Figuring out physical memory regions from a kernel module
Thread-Index: AcTdTXbGUOr97WBjSfq+1w7Wq9CmXA==
From: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Dec 2004 17:44:10.0320 (UTC) FILETIME=[85FA2500:01C4DD4D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Is there a reliable way to tell from a kernel module (currently
written for 2.4 but will need to work under 2.6 in the future) which
regions of physical memory are actually available for the kernel and
processes to use? For example, the following command tells me the
regions of physical memory that are available to use:

cat /proc/iomem | grep 'System RAM'

This yields something like the following on my x86 system:

00000000-0009ffff : System RAM
00100000-1ffd5857 : System RAM

I need to be able to determine these regions from within a kernel
module. The e820 data structures configured at kernel boot-time are not
exported so I can't see them from a kernel module, otherwise they would
be perfect. For my purposes, I'm operating under the assumption that all
physical memory can be mapped by the kernel (under 896 MB of physical
memory). Can anyone recommend a way to get to this data? I would greatly
appreciate it.

