Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267929AbUHETob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267929AbUHETob (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 15:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267926AbUHETob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 15:44:31 -0400
Received: from fmr99.intel.com ([192.55.52.32]:35979 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S267920AbUHEToU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 15:44:20 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Fastboot] Re: [BROKEN PATCH] kexec for ia64
Date: Thu, 5 Aug 2004 12:44:05 -0700
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB00750E615@fmsmsx406.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Fastboot] Re: [BROKEN PATCH] kexec for ia64
Thread-Index: AcR7CHCCIob3VnJSQN6+umx3WgNrxgAG1mgQ
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Grant Grundler" <iod00d@hp.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, <linux-ia64@vger.kernel.org>,
       "Jesse Barnes" <jbarnes@engr.sgi.com>, <linux-kernel@vger.kernel.org>,
       <fastboot@osdl.org>
X-OriginalArrivalTime: 05 Aug 2004 19:44:05.0319 (UTC) FILETIME=[90E51D70:01C47B24]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, Aug 04, 2004 at 08:14:55PM -0600, Eric W. Biederman wrote:
>> VGA/serial console devices rarely need to do be bus masters so they
>> should be fine.
>
>yeah - you are right. I wasn't thinking.
>Can anyone comment on UGA or other console devices?

UGA is essentially a PCI device.  It uses the EFI PCI I/O 
protocol which gets glued to the kernels pci layer...at least in 
a prototype.  

I haven't looked at the latest kexec patch.  How is it handling
the call to EFI's SetVirtualAddressMap()?  Is it part of the config
associated with kexec to do efi calls in physical mode only so that
it doesn't have to contend with potential follow-on invocations 
resultant from "the next" kernel's initialization?

matt
