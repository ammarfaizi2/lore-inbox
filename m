Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVEPT6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVEPT6R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 15:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbVEPT6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 15:58:16 -0400
Received: from hqemgate03.nvidia.com ([216.228.112.143]:52493 "EHLO
	HQEMGATE03.nvidia.com") by vger.kernel.org with ESMTP
	id S261848AbVEPTya convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 15:54:30 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Broken nForce2 IDE module loading via hotplug
Date: Mon, 16 May 2005 12:54:28 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B00604C7BC@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Broken nForce2 IDE module loading via hotplug
thread-index: AcVX5kN79FIN3AGoQPmc01G3lmn+cwCapSyw
From: "Andrew Chew" <AChew@nvidia.com>
To: "Jeff Garzik" <jgarzik@pobox.com>, "Juerg Billeter" <juerg@paldo.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 May 2005 19:54:28.0319 (UTC) FILETIME=[118C5EF0:01C55A51]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the kernel config option to disable the generic entry is a good
idea.  Jeff, want me to submit a patch for this? 

-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@pobox.com] 
Sent: Friday, May 13, 2005 11:05 AM
To: Juerg Billeter
Cc: Andrew Chew; linux-kernel@vger.kernel.org
Subject: Re: Broken nForce2 IDE module loading via hotplug

Juerg Billeter wrote:
> Hi
> 
> (please cc me)
> 
> The sata_nv patch[1] (merged in 2.6.11-rc4) to enable future NVIDIA
SATA
> pci ids catches all NVIDIA pci devices with the ide class. This breaks
> automatic module loading for e.g. nForce2 ide controllers and thereby
> renders nForce systems loading modules already in initramfs/initrd via
> hotplug/coldplug non-bootable.
> 
> I don't know what solutions are possible besides reverting. Is it
> somehow possible to influence the order of the modules.pcimap file,
i.e.
> moving the generic matching lines below the more specific ones?

It might be fair to add a kernel config option to disable the generic
entry.

	Jeff



