Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbUBTTFl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 14:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbUBTTFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:05:41 -0500
Received: from palrel11.hp.com ([156.153.255.246]:40614 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261267AbUBTTFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:05:33 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16438.23159.786654.810621@napali.hpl.hp.com>
Date: Fri, 20 Feb 2004 11:05:27 -0800
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: "Andreas Schwab" <schwab@suse.de>, <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH]2.6.3-rc2 MSI Support for IA64
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E5024040580FB@orsmsx404.jf.intel.com>
References: <C7AB9DA4D0B1F344BF2489FA165E5024040580FB@orsmsx404.jf.intel.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 20 Feb 2004 10:36:12 -0800, "Nguyen, Tom L" <tom.l.nguyen@intel.com> said:

  Tom> To avoid some #ifdef statements as possible, "ia64_platform" 
  Tom> defined in the header file "msi.h" is set to TRUE only if 
  Tom> setting CONFIG_IA64 to 'Y'. The setting of ia64_platform
  Tom> to TRUE will execute function ia64_alloc_vector.

  Tom> This API is only used in assign_msi_vector()in msi.c:

  Tom> vector = (ia64_platform ? ia64_alloc_vector() : assign_irq_vector(MSI_AUTO));

Surely this can be abstracted properly?

	--david
