Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbULHV0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbULHV0v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 16:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbULHV0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 16:26:51 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:930 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id S261363AbULHV0s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 16:26:48 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Figuring out physical memory regions from a kernel module
Date: Wed, 8 Dec 2004 14:26:43 -0700
Message-ID: <C863B68032DED14E8EBA9F71EB8FE4C20596063B@azsmsx406>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Figuring out physical memory regions from a kernel module
Thread-Index: AcTdVWimpd/RBNAtSqalFa/Bv8kCmAAFePYw
From: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
To: <haveblue@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Dec 2004 21:26:43.0587 (UTC) FILETIME=[9D24FD30:01C4DD6C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Dave Hansen [mailto:haveblue@us.ibm.com] 
Sent: Wednesday, December 08, 2004 11:40 AM
To: Hanson, Jonathan M
Cc: Linux Kernel Mailing List
Subject: RE: Figuring out physical memory regions from a kernel module

On Wed, 2004-12-08 at 10:28, Hanson, Jonathan M wrote:
>  The module is dumping the contents of physical memory
> and saving the architecture state of the system to a file when
triggered
> (ioctl call). What I have works but I need to extend it to systems
other
> than my own where I have hard-coded the system RAM regions into the
> code. I need the physical addresses of memory because the tool I feed
> this output into requires this. Here is an example of what the memory
> file looks like:

Sounds like crash dumping.  I think they've already run into and
addressed the same general problems.  

See crashdump-*.patch in here:
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc
2/2.6.10-rc2-mm4/broken-out/

-- Dave

[Jon M. Hanson] Even looking at the implementation of the crashdump
code, I still encounter the same problem I've run into up until now: the
crashdump code is a part of the kernel so it has access to all of the
kernel's data structures and functions; as a kernel module, I'm
hamstrung by what is exported by the kernel. I know that I can modify
the kernel to export whatever I want but I don't want to have to do
that. I want to be able to run my kernel module without having to patch
the kernel itself.

