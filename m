Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263012AbUJ1Vu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbUJ1Vu6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 17:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbUJ1VrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 17:47:18 -0400
Received: from fmr05.intel.com ([134.134.136.6]:4069 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S263030AbUJ1Vmw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 17:42:52 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Userspace ACPI interpreter
Date: Thu, 28 Oct 2004 14:42:18 -0700
Message-ID: <37F890616C995246BE76B3E6B2DBE05502764B4F@orsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Userspace ACPI interpreter
Thread-Index: AcS9AizHiNcYvFbkSRCi4wuqqHGf0AAND0dw
From: "Moore, Robert" <robert.moore@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>, "Brown, Len" <len.brown@intel.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "Therien, Guy" <guy.therien@intel.com>
Cc: "Yu, Luming" <luming.yu@intel.com>, "Bjorn Helgaas" <bjorn.helgaas@hp.com>,
       "Alex Williamson" <alex.williamson@hp.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 28 Oct 2004 21:42:19.0552 (UTC) FILETIME=[00162A00:01C4BD37]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been working on the ACPI CA project for over 6 years, and trust me,
this has been tried before.  There are significant reasons for having
the interpreter in the kernel.

You don't really want to page out the interpreter when you are using it
for things like suspend/resume, thermal control, and many other things.

I think we have a list around somewhere with many of the reasons, I will
look for it.

Bob


> -----Original Message-----
> From: Theodore Ts'o [mailto:tytso@thunk.org] On Behalf Of Theodore
Ts'o
> Sent: Thursday, October 28, 2004 8:24 AM
> To: Brown, Len
> Cc: Yu, Luming; Bjorn Helgaas; Moore, Robert; Alex Williamson; linux-
> kernel; acpi-devel@lists.sourceforge.net
> Subject: Re: Userspace ACPI interpreter ( was RE: [ACPI] [RFC]
dev_acpi:
> support for userspace access to acpi)
> 
> On Thu, Oct 28, 2004 at 01:37:52AM -0400, Len Brown wrote:
> > One way to experiment with a user-mode ACPI interpreter would be to
> > continue to use the kernel-mode interpreter for boot up , and cut
over
> > to the user-mode interpreter at /sbin/init.  The kernel-mode
interpreter
> > could be sent the way of free_initmem() which is called just before
> > /sbin/init is invoked.
> 
> Is there a significant advantage to doing having a user-mode ACPI
> interpreter?  The only advantage I can think of is that the ACPI
> interpreter could now live in pageable memory.  Are there any others?
> 
> 					- Ted
