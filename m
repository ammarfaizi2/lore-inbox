Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262379AbVBLA7C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbVBLA7C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 19:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbVBLA7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 19:59:02 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:9434 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id S262379AbVBLA67 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 19:58:59 -0500
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Using O_DIRECT for file writing in a kernel module
Date: Fri, 11 Feb 2005 17:58:57 -0700
Message-ID: <C863B68032DED14E8EBA9F71EB8FE4C20639287E@azsmsx406>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Using O_DIRECT for file writing in a kernel module
Thread-Index: AcUQnBs1Z359DxBOTymFjwmp+gYZ5A==
From: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Feb 2005 00:58:58.0254 (UTC) FILETIME=[0872B6E0:01C5109E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I'm trying to write to a file with the O_DIRECT flag from a
kernel module in a 2.4 series of kernel on x86 hardware. I've learned
that the O_DIRECT flag requires that the amount of data written and the
file offset pointer must be multiples of the underlying "block size."
	To try things out I've been successful is writing to a file with
O_DIRECT in user space using multiples of PAGE_SIZE.
	However, when I try to do the same from my kernel module I'm
always greeted with an -EINVAL as the return code from the write call
when trying multiples of PAGE_SIZE. Then I realized that the kernel uses
four megabyte pages and not four kilobyte pages so I tried passing four
megabytes of data to the write call but also got -EINVAL in return.
	Is it possible to use O_DIRECT to write a file from a kernel
module? If so, what size of data do I need to pass so that it will work?
I've been through Google and the kernel source code but didn't see an
answer as to the size required to get it to work.
	Thanks in advance for any assistance offered.

