Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVCYTIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVCYTIp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 14:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVCYTIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 14:08:44 -0500
Received: from fmr21.intel.com ([143.183.121.13]:35001 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261747AbVCYTIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 14:08:31 -0500
Subject: Re: [ACPI] Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
From: Len Brown <len.brown@intel.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Shaohua Li <shaohua.li@intel.com>, Grzegorz Kulewski <kangur@polcom.net>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1111688662.24547.26.camel@eeyore>
References: <41062.15.99.19.46.1111525073.squirrel@mail.atl.hp.com>
	 <1111539249.18927.17.camel@sli10-desk.sh.intel.com>
	 <1110.65.74.231.82.1111550240.squirrel@mail.cce.hp.com>
	 <1111603235.17317.883.camel@d845pe>  <1111688662.24547.26.camel@eeyore>
Content-Type: text/plain
Organization: 
Message-Id: <1111777662.19921.43.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 25 Mar 2005 14:07:43 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.

thanks,
-Len

On Thu, 2005-03-24 at 13:24, Bjorn Helgaas wrote:
> On Wed, 2005-03-23 at 13:40 -0500, Len Brown wrote:
> > But checking skip_ioapic_setup in the non-ACPI case
> > isn't quite right.  This is set for "noapic".  But
> > it is not set in the PIC-mode case where the kernel
> > supports IOAPIC but the hardware does not -- in that
> > case the quirk would erroneously exit.
> 
> Ah, right, thanks.  I changed it to:
> 
>         if (nr_ioapics && !skip_ioapic_setup)
>                 return;
> 
> Is that better?
> 
> > Also, the original quirk_via_irqpic()
> > had a udelay(15) before the write -- I have no idea
> > if that was significant or not -- maybe soembody else
> > on the list does -- as none of us have VIA documentation...
> 
> Yes, I was worried about that, too.  I added it back.
> 
> > ps. we need to fix this on 2.4 also.
> 
> Here's yet another iteration for 2.6.  If this works OK,
> I can back-port it to 2.4.
...

