Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbUBTTnU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 14:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbUBTTmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:42:44 -0500
Received: from fmr06.intel.com ([134.134.136.7]:24529 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261392AbUBTTiO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:38:14 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH]2.6.3-rc2 MSI Support for IA64
Date: Fri, 20 Feb 2004 11:38:05 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024040580FF@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]2.6.3-rc2 MSI Support for IA64
Thread-Index: AcP35IX7O7bY627mQam4akDjx5KbzgAA7vXg
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: <davidm@hpl.hp.com>
Cc: "Andreas Schwab" <schwab@suse.de>, <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Luck, Tony" <tony.luck@intel.com>
X-OriginalArrivalTime: 20 Feb 2004 19:38:06.0248 (UTC) FILETIME=[0FE2FA80:01C3F7E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friday, Feb. 20, 2004 11:05 AM, David Mosberger wrote:

>  Tom> To avoid some #ifdef statements as possible, "ia64_platform" 
>  Tom> defined in the header file "msi.h" is set to TRUE only if 
>  Tom> setting CONFIG_IA64 to 'Y'. The setting of ia64_platform
>  Tom> to TRUE will execute function ia64_alloc_vector.

>  Tom> This API is only used in assign_msi_vector()in msi.c:

>  Tom> vector = (ia64_platform ? ia64_alloc_vector() : assign_irq_vector(MSI_AUTO));

> Surely this can be abstracted properly?

This patch was tested on both IA64 (Intel and HP) machines and I386 machine
in our lab.

Thanks,
Long
