Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262946AbTESVeT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 17:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbTESVeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 17:34:19 -0400
Received: from fmr01.intel.com ([192.55.52.18]:40653 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262946AbTESVeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 17:34:18 -0400
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024136211@orsmsx404.jf.intel.com>
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: linux-kernel@vger.kernel.org, "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Carbonari, Steven" <steven.carbonari@intel.com>
Subject: RE: RFC Proposal to enable MSI support in Linux kernel
Date: Mon, 19 May 2003 14:46:59 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By default, one single message (MSI) is assigned to any MSI/MSI-X capable
device regardless of whether the device is capable of handling a single or
multiple messages. Due the current implementation of assigning vector in
Linux, the PCI subsystem assigns one single message to the device, which
implements the MSI capability structure. However, for the device
implementing the MSI-X capability structure, the device driver can request
for additional messages by calling the API: 

int msi_alloc_vectors(void* dev_id, int *vector, int nvec) 

Thanks,
Tom

-----Original Message-----
From: Zwane Mwaikambo [mailto:zwane@linuxpower.ca]
Sent: Wednesday, May 14, 2003 12:06 PM
To: Nguyen, Tom L
Cc: linux-kernel@vger.kernel.org; Saxena, Sunil; Mallick, Asit K;
Nakajima, Jun; Carbonari, Steven
Subject: Re: RFC Proposal to enable MSI support in Linux kernel


Do you require mulitple vectors per device? Can't you assign one and then 
multiplex in your handler? Or is there some mode of operation i've not 
taken into account?

	Zwane
-- 
function.linuxpower.ca
