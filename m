Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVCNURA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVCNURA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 15:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbVCNURA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 15:17:00 -0500
Received: from fmr19.intel.com ([134.134.136.18]:38049 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261354AbVCNUQh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 15:16:37 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] PCI Express Advanced Error Reporting Driver
Date: Mon, 14 Mar 2005 12:16:28 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502408070E64@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] PCI Express Advanced Error Reporting Driver
Thread-Index: AcUmjZZKrS3vBFHIT/eGkRWDxlZxBQCQ0E2g
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Paul Mackerras" <paulus@samba.org>
Cc: "Greg KH" <greg@kroah.com>, <benh@kernel.crashing.org>,
       <linux-kernel@vger.kernel.org>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 14 Mar 2005 20:16:30.0439 (UTC) FILETIME=[B5919F70:01C528D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 11, 2005 2:49 PM Paul Mackerras wrote:
>> The standard PCI Specification calls out SERR and PERR. I am not sure
>> about the recent discussion of PCI error of recovery. It is perhaps
>> regarding the possibility of recovering from a PERR or SERR. However,
>> PCI Express error occurs on the PCI Express link or on behalf of
>> transactions occurred on the PCI Express link. PCI Express component,
>> which implements PCI Express Advanced Error Reporting Capability,
sends
>> error message to the Root Port to indicate error occurred on the PCI
>> Express link where it is connected. The PCI Express error recovery is
on
>> behalf of attempting to do a PCI Express link recovery, not PCI error
>> recovery. It appears that PCI Express AER is disjoint from PCI error
>> recovery.
>
>To give you some context, the recent discussion was about how we could
>give a unified interface to drivers for both PCI-Express error
>reporting and for the "Enhanced Error Handling" (EEH) facilities we
>have on IBM PPC64 boxes.  EEH includes not only the detection and
>reporting of errors (for PCI, PCI-X and PCI-Express buses) but also
>hardware support for isolating devices when an error is detected, plus
>means for resetting individual bus segments or slots, to assist in
>recovering a device which has got into a bad state.

Thanks for providing this information.

>Does PCI Express provide any facilities for recovering from errors,
>beyond just "try that transaction again"?

PCI Express AER Root driver provides AER callback interfaces to
coordinate with PCI Express AER aware drivers. However, based on recent
LKML inputs, we like the suggestion for a common interface in the
drivers to support error handling for different platforms.

Thanks,
Long
