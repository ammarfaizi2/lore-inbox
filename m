Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263961AbRFNT6Q>; Thu, 14 Jun 2001 15:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263974AbRFNT6G>; Thu, 14 Jun 2001 15:58:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:22963 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263961AbRFNT5p>;
	Thu, 14 Jun 2001 15:57:45 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15145.5939.879723.656331@pizda.ninka.net>
Date: Thu, 14 Jun 2001 12:57:39 -0700 (PDT)
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Tom Gall <tom_gall@vnet.ibm.com>
Subject: Re: Going beyond 256 PCI buses
In-Reply-To: <3B29137B.CA8442B8@mandrakesoft.com>
In-Reply-To: <15145.1739.395626.842663@pizda.ninka.net>
	<200106141904.f5EJ4AD413350@saturn.cs.uml.edu>
	<15145.3254.105970.424506@pizda.ninka.net>
	<3B29137B.CA8442B8@mandrakesoft.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik writes:
 > Thinking a bit more independently of bus type, and with an eye toward's
 > 2.5's s/pci_dev/device/ and s/pci_driver/driver/, would it be useful to
 > go ahead and codify the concept of PCI domains into a more generic
 > concept of bus tree numbers?  (or something along those lines)  That
 > would allow for a more general picture of the entire system's device
 > tree, across buses.
 > 
 > First sbus bus is tree-0, first PCI bus tree is tree-1, second PCI bus
 > tree is tree-2, ...

If you're going to do something like this, ie. true hierarchy, why not
make one tree which is "system", right? Use /proc/bus/${controllernum}
ala:

/proc/bus/0/type	--> "sbus", "pci", "zorro", etc.
/proc/bus/0/*		--> for type == "pci" ${bus}/${dev}.${fn}
			    for type == "sbus" ${slot}
			    ...

How about this?

Later,
David S. Miller
davem@redhat.com

