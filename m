Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264489AbTH2Jvi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 05:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264497AbTH2Jvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 05:51:37 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:43177 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264490AbTH2Jvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 05:51:36 -0400
Subject: Re: Single P4, many IDE PCI cards == trouble??
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Urbanik <nicku@vtc.edu.hk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F4EA30C.CEA49F2F@vtc.edu.hk>
References: <3F4EA30C.CEA49F2F@vtc.edu.hk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062150643.26753.4.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 29 Aug 2003 10:50:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-08-29 at 01:49, Nick Urbanik wrote:
> Dear Folks,
> 
> With a single 2.26GHz P4, an Asus P4B533-E motherboard, is it possible
> to reliably use two additional PCI IDE cards (using SI680), one hard
> disk per channel, and have the thing work reliably?

You should be able to, although with software raid your PCI bandwidth
limits will limit the ultimate performance for mirroring/raid

> My machine locks solid at unpredictable intervals with no response
> from keyboard lights, no Alt-Sysrq-x response, etc, with a wide
> variety of 2.4.x kernels, including 2.4.22.

A freeze in an IRQ handler would cause that kind of thing, turning on 
the NMI watchdog might get you a trace in such a failure case - and 
that would help.

