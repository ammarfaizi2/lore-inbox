Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262325AbUK3VhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbUK3VhH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 16:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbUK3VhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 16:37:06 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:32833 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id S262325AbUK3Vgs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 16:36:48 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Walking all the physical memory in an x86 system
Date: Tue, 30 Nov 2004 14:36:27 -0700
Message-ID: <C863B68032DED14E8EBA9F71EB8FE4C2058057A1@azsmsx406>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Walking all the physical memory in an x86 system
Thread-Index: AcTXI3+uzPbOQJnvROKMZe0B4m8APwAAJd8g
From: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
To: <jengelh@linux01.gwdg.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Nov 2004 21:36:28.0184 (UTC) FILETIME=[A6496980:01C4D724]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Jan Engelhardt [mailto:jengelh@linux01.gwdg.de] 
Sent: Tuesday, November 30, 2004 2:28 PM
To: Hanson, Jonathan M
Cc: linux-kernel@vger.kernel.org
Subject: RE: Walking all the physical memory in an x86 system

>[Jon M. Hanson] I can read /dev/mem from a userspace application as
root
>with no problems and print out what it sees. However, things are not so
>simple from a kernel module as I just can't call open() and read() on
>/dev/mem because no such functions are exported from the kernel. Is
>there a way to read the contents of /dev/mem from a kernel module?

You can use filp_open().


Jan Engelhardt
-- 
ENOSPC

[Jon M. Hanson] I tried the filp_open() approach like this:

struct file *mem_fd;

mem_fd = filp_open("/dev/mem", O_RDONLY | O_LARGEFILE, 0);

I then have a check if IS_ERR(mem_fd) is true immediately afterwards
along with a printk saying it failed. This condition is true when I ran
it.


