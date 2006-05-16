Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWEPVit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWEPVit (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 17:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWEPVit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 17:38:49 -0400
Received: from mga03.intel.com ([143.182.124.21]:63406 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932081AbWEPVis convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 17:38:48 -0400
Message-Id: <4t153d$13lgbu@azsmga001.ch.intel.com>
X-IronPort-AV: i="4.05,134,1146466800"; 
   d="scan'208"; a="37405054:sNHT47587218"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "=?iso-8859-1?Q?'=22D=F6hr=2C_Markus_ICC-H=22'?=" 
	<Markus.Doehr@siegenia-aubi.com>,
       "Ju, Seokmann" <Seokmann.Ju@lsil.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: <linux-scsi@vger.kernel.org>
Subject: RE: Help: strange messages from kernel on IA64 platform
Date: Tue, 16 May 2006 14:38:42 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcZ5LvIqASmYD3+JTwWm+kHEAnZFggAAWAWg
In-Reply-To: <FC7F4950D2B3B845901C3CE3A1CA6766015CC246@mxnd200-9.si-aubi.siegenia-aubi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Döhr, Markus ICC-H wrote on Tuesday, May 16, 2006 2:20 PM
> > During communication in between application and megaraid 
> > driver via IOCTL, the system displays messages which are not 
> > easy to track down.
> > Following is one of the messages and same messages with 
> > different values are poping up regularly.
> > ---
> > Kernel unaligned access to 0xe00000007f3d80dc ip=0xa0000002000373b1
> > ---
> 
> We have this message too on our main database server; the interesting part
> is, that the application, which triggers this error, is a database (MaxDB)
> and the process name is "kernel"... Just to avoid confusion: look if there's
> an application with such name running on your system.

Unaligned access warning for user space process will print in a slightly
different format.  It will print process name and its pid, something like:

cgc(15270): unaligned access to 0x20000000002b8025, ip=0x4000000000000b21

(you can also make the differentiation by looking at the data and instruction
 address).

- Ken
