Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275596AbTHMVRQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 17:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275598AbTHMVRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 17:17:15 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:47532 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S275596AbTHMVQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 17:16:52 -0400
To: Greg KH <greg@kroah.com>
Cc: "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       rddunlap@osdl.org, davej@redhat.com, willy@debian.org,
       linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
References: <20030812112729.GF3169@parcelfarce.linux.theplanet.co.uk>
	<20030812180158.GA1416@kroah.com> <3F397FFB.9090601@pobox.com>
	<20030812171407.09f31455.rddunlap@osdl.org>
	<3F3986ED.1050206@pobox.com>
	<20030812173742.6e17f7d7.rddunlap@osdl.org>
	<20030813004941.GD2184@redhat.com>
	<32835.4.4.25.4.1060743746.squirrel@www.osdl.org>
	<3F39AFDF.1020905@pobox.com>
	<20030813031432.22b6a0d6.davem@redhat.com>
	<20030813173150.GA3317@kroah.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 13 Aug 2003 22:21:48 +0200
In-Reply-To: <20030813173150.GA3317@kroah.com>
Message-ID: <m31xvpe2ar.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> -	{ PCI_VENDOR_ID_ALTIMA, PCI_DEVICE_ID_ALTIMA_AC9100,
> -	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5700) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5701) },

We might even consider

+	{ PCI_DEVICE(BROADCOM, TIGON3_5700) },
+	{ PCI_DEVICE(BROADCOM, TIGON3_5701) },

As probably using anything but PCI_DEVICE_ID_* and PCI_VENDOR_ID_*
would be a bug.

+#define PCI_DEVICE(vend,dev) \
+	.vendor = (PCI_VENDOR_ID_##vend), .device = (PCI_DEVICE_ID_##dev), \
+	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID

-- 
Krzysztof Halasa
Network Administrator
