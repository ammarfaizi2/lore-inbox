Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVETU05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVETU05 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 16:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVETU04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 16:26:56 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:27856 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S261571AbVETU0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 16:26:44 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 1/1] Proposed: Let's not waste precious IRQs...
Date: Fri, 20 May 2005 14:26:21 -0600
User-Agent: KMail/1.8
Cc: Natalie.Protasevich@unisys.com, akpm@osdl.org, ak@suse.de,
       zwane@arm.linux.org.uk, "Brown, Len" <len.brown@intel.com>,
       linux-kernel@vger.kernel.org
References: <20050519110613.B817D27266@linux.site> <20050520064531.A14497@unix-os.sc.intel.com>
In-Reply-To: <20050520064531.A14497@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505201426.21527.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 May 2005 7:45 am, Ashok Raj wrote:
> have you taken a look a the Vector Sharing Patch posted by Kaneshige for IA64?

Vector sharing has a performance cost, so we should avoid it when
we can.

I think you should bounds-check the gsi_to_irq[] references.  When
you finally get a machine with GSI values larger than MAX_GSI_NUM,
things will start failing mysteriously as you corrupt things after
the gsi_to_irq[] array.
