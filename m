Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293314AbSCOVcY>; Fri, 15 Mar 2002 16:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293306AbSCOVcP>; Fri, 15 Mar 2002 16:32:15 -0500
Received: from fmr02.intel.com ([192.55.52.25]:32723 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S293314AbSCOVb6>; Fri, 15 Mar 2002 16:31:58 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7D01@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, reality@delusion.de
Cc: linux-kernel@vger.kernel.org, "Grover, Andrew" <andrew.grover@intel.com>
Subject: RE: [OOPS] Kernel powerdown
Date: Fri, 15 Mar 2002 13:30:56 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> > flushing ide devices: hda hdb hde 
> > Power down.
> > NMI Watchdog detected LOCKUP on CPU0
> Looks like the ACPI code is simply forgetting to turn off the 
> NMI watchdog

Does the machine power off successfully using ACPI when the NMI watchdog is
not enabled?

Theoretically we should be turning the machine off, after which I'm pretty
sure the NMI watchdog shouldn't be an issue :) but IIRC we are masking
interrupts and doing some delays before turning off, so the NMI watchdog
might not be liking that? APM doesn't turn off the NMI afaik so why should
ACPI have to?

-- Andy
