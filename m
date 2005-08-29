Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbVH2F24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbVH2F24 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 01:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbVH2F24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 01:28:56 -0400
Received: from outmx003.isp.belgacom.be ([195.238.2.100]:9668 "EHLO
	outmx003.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1750806AbVH2F2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 01:28:55 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: USB EHCI Problem with Low Speed Devices on kernel 2.6.11+
Date: Mon, 29 Aug 2005 07:28:06 +0200
User-Agent: KMail/1.8.1
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>,
       Dominik Wezel <dio@qwasartech.com>
References: <43106DEF.3040206@qwasartech.com> <431245E2.5010308@superbug.demon.co.uk>
In-Reply-To: <431245E2.5010308@superbug.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508290728.07102.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 August 2005 01:16, James Courtier-Dutton wrote:
> Dominik Wezel wrote:
> > Problem
> > =======
> > When turning on the laptop and during POST and GrUB loading, all ports
> > on the hub are enabled.  During the USB initialization phase, when the
> > hub is detected, shortly all ports become disabled, then turn on again
> > (uhci_hcd detects the lo-speed ports).  Upon initialization of ehci_hcd
> > however, the ports are disconnected again (for good):
>
> Use uhci_hcd or ehci_hcd, but never both at the same time.
> ehci_hcd will work with all lo-speed ports, so uhci_hcd is then no needed.

This seems to be in contrast with what hotplug does automatically: it loads 
both ehci_hcd and uhci_hcd here. If I don't load uhci_hcd, lo-speed devices 
do not work.

Jan

-- 
A grammarian's life is always in tense.
