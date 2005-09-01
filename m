Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030370AbVIAU7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbVIAU7l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbVIAU7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:59:41 -0400
Received: from fmr20.intel.com ([134.134.136.19]:57490 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030370AbVIAU7l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:59:41 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC/PATCH]reconfigure MSI registers after resume
Date: Thu, 1 Sep 2005 13:59:32 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502409A45B38@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC/PATCH]reconfigure MSI registers after resume
thread-index: AcWvMWeSvNbBA+djTF2BZp8k1+IfHAABh0KQ
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <greg@kroah.com>, "Li, Shaohua" <shaohua.li@intel.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Sep 2005 20:59:34.0157 (UTC) FILETIME=[0E38F3D0:01C5AF38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 01, 2005 1:10 PM Andrew Morton wrote:
>>
>> On Thursday, September 01, 2005 12:32 PM Andrew Morton wrote:
>> > So what is the alternative to Shaohua's fix?  Restore all the msi 
>> > registers on resume?
>> 
>> Yes, the PCIe port bus driver, for example, did that.
>> 

> So you're saying that each individual driver which uses MSI is
responsible
> for the restore?  
Yes.

> Is it not possible to do this in some single centralized place?
Existing pci_save_state(dev)/pci_restore_state(dev) covers only 64 bytes
of PCI header. One solution is to extend these APIs to cover up to 256
bytes. What do you think?

Thanks,
Tom
