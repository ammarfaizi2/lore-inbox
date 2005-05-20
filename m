Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVETN7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVETN7A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 09:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVETN7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 09:59:00 -0400
Received: from fmr22.intel.com ([143.183.121.14]:52450 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261457AbVETNqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 09:46:05 -0400
Date: Fri, 20 May 2005 06:45:32 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Natalie.Protasevich@unisys.com
Cc: akpm@osdl.org, ak@suse.de, zwane@arm.linux.org.uk,
       "Brown, Len" <len.brown@intel.com>, bjorn.helgaas@hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] Proposed: Let's not waste precious IRQs...
Message-ID: <20050520064531.A14497@unix-os.sc.intel.com>
References: <20050519110613.B817D27266@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050519110613.B817D27266@linux.site>; from Natalie.Protasevich@unisys.com on Thu, May 19, 2005 at 04:06:13AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Natalie,

have you taken a look a the Vector Sharing Patch posted by Kaneshige for IA64?

Cheers,
ashok


On Thu, May 19, 2005 at 04:06:13AM -0700, Natalie.Protasevich@unisys.com wrote:
> 
>    I  suggest  to  change  the  way  IRQs  are handed out to PCI devices.
>    Currently, each I/O APIC pin gets associated with an IRQ, no matter if
>    the  pin  is used or not. It is expected that each pin can potentually
>    be  engaged  by  a  device  inserted  into the corresponding PCI slot.
>    However,  this  imposes severe limitation on systems that have designs
>    that employ many  I/O APICs, only utilizing couple lines of each, such
>    as P64H2 chipset. It is used in ES7000, and currently, there is no way
>    to boot the system with more that 9 I/O APICs. The simple change below
>    allows  to  boot  a  system  with  say  64  (or  more) I/O APICs, each
>    providing  1  slot, which otherwise impossible because of the IRQ gaps
>    created  for  unused  lines  on each I/O APIC. It does not resolve the
>    problem  with  number of devices that exceeds number of possible IRQs,
>    but  eases  up a tension for IRQs on any large system with potentually
>    large  number  of  devices. I only implemented this for the ACPI boot,
>    since if the system is this big and
>.. deleted... 
