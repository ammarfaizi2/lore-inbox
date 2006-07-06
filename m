Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWGFThj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWGFThj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWGFThj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:37:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:16940 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750759AbWGFThh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:37:37 -0400
X-IronPort-AV: i="4.06,214,1149490800"; 
   d="scan'208"; a="61496180:sNHT2277968175"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Linux v2.6.18-rc1
Date: Thu, 6 Jul 2006 12:25:37 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A48DFCEA@orsmsx415.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux v2.6.18-rc1
Thread-Index: Acag+JdwNc3xvm/tSgGhHwyfx/utfgAOSM8A
From: "Moore, Robert" <robert.moore@intel.com>
To: "Alistair John Strachan" <s0348365@sms.ed.ac.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 06 Jul 2006 19:25:37.0845 (UTC) FILETIME=[F5F2FE50:01C6A131]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tracked this down, it's a bug and I believe I have it fixed. It's
related to "serialized" control methods which are rather rare in
comparison to non-serialized methods.

Bob


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Alistair John Strachan
> Sent: Thursday, July 06, 2006 5:35 AM
> To: Linus Torvalds
> Cc: Linux Kernel Mailing List; linux-acpi@vger.kernel.org; Brown, Len
> Subject: Re: Linux v2.6.18-rc1
> 
> On Thursday 06 July 2006 05:26, Linus Torvalds wrote:
> > Ok,
> >  the merge window for 2.6.18 is closed, and -rc1 is out there (git
trees
> > updated, the tar-ball and patches are still uploading over my
pitiful
> DSL
> > line - and as usual it may take a short while before mirroring takes
> > place and distributes things across the globe).
> >
> > The changes are too big for the mailing list, even just the
shortlog. As
> > usual, lots of stuff happened. Most architectures got updated, ACPI
> > updates, networking, SCSI and sound, IDE, infiniband, input, DVB etc
etc
> > etc.
> 
> ACPI problem here. Doesn't seem to actively break anything, but the
> messages
> look bad (HP NC6000 notebook). Haven't tried suspending. The error
popped
> up roughly 90 minutes after booting. Laptop has been on AC power
> throughout.
> 
> ACPI Error (exmutex-0248): Cannot release Mutex [C0E8], not acquired
> [20060623]
> ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.C044.C057.C0E7.C12F] (Node c1aeca40), AE_AML_MUTEX_NOT_ACQUIRED
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.C12F]
> (Node c1aeecfc), AE_AML_MUTEX_NOT_ACQUIRED
> ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.C137._BST]
> (Node c1aeec84), AE_AML_MUTEX_NOT_ACQUIRED
> ACPI Exception (acpi_battery-0206): AE_AML_MUTEX_NOT_ACQUIRED,
Evaluating
> _BST [20060623]
> 
> --
> Cheers,
> Alistair.
> 
> Third year Computer Science undergraduate.
> 1F2 55 South Clerk Street, Edinburgh, UK.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
