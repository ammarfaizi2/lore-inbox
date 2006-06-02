Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWFBUsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWFBUsF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 16:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWFBUsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 16:48:05 -0400
Received: from a34-mta01.direcpc.com ([66.82.4.90]:42384 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S964835AbWFBUsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 16:48:03 -0400
Date: Fri, 02 Jun 2006 16:46:01 -0400
From: Ben Collins <bcollins@ubuntu.com>
Subject: Re: [PATCH 2.6.17-rc5-mm2 17/18] sbp2: provide helptext for
	CONFIG_IEEE1394_SBP2_PHYS_DMA and mark it experimental
In-reply-to: <tkrat.df90273c07dd7503@s5r6.in-berlin.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>
Message-id: <1149281162.4533.304.camel@grayson>
Organization: Ubuntu
MIME-version: 1.0
X-Mailer: Evolution 2.6.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <tkrat.10011841414bfa88@s5r6.in-berlin.de>
 <tkrat.31172d1c0b7ae8e8@s5r6.in-berlin.de>
 <tkrat.51c50df7e692bbfa@s5r6.in-berlin.de>
 <tkrat.f22d0694697e6d7a@s5r6.in-berlin.de>
 <tkrat.ecb0be3f1632e232@s5r6.in-berlin.de>
 <tkrat.687a0a2c67fa40c6@s5r6.in-berlin.de>
 <tkrat.f35772c971022262@s5r6.in-berlin.de>
 <tkrat.df7a29e56d67dd0a@s5r6.in-berlin.de>
 <tkrat.29d9bcd5406eb937@s5r6.in-berlin.de>
 <tkrat.9a30b61b3f17e5ac@s5r6.in-berlin.de>
 <tkrat.5222feb4e2593ac0@s5r6.in-berlin.de>
 <tkrat.5fcbbb70f827a5c2@s5r6.in-berlin.de>
 <tkrat.39c0a660f27b4e91@s5r6.in-berlin.de>
 <tkrat.4daedad8356d5ae7@s5r6.in-berlin.de>
 <tkrat.8f06b4d6dec62d08@s5r6.in-berlin.de>
 <tkrat.8a65694fd3ed4036@s5r6.in-berlin.de>
 <tkrat.96e1b392429fe277@s5r6.in-berlin.de>
 <tkrat.df90273c07dd7503@s5r6.in-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-02 at 22:27 +0200, Stefan Richter wrote:
> It appears I will not get it fixed overnight.

> -	bool "Enable Phys DMA support for SBP2 (Debug)"
> -	depends on IEEE1394 && IEEE1394_SBP2
> +	bool "Enable replacement for physical DMA in SBP2"
> +	depends on IEEE1394 && IEEE1394_SBP2 && EXPERIMENTAL

Please add '&& !SPARC' to the depends line. Other architectures may
apply, but I know for sure that this cannot be enabled on SPARC or
SPARC64 since the module will be unloadable due to missing symbols
(virt_to_bus, bus_to_virt).

-- 
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/

