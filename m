Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263934AbRFDCYr>; Sun, 3 Jun 2001 22:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263935AbRFDCYh>; Sun, 3 Jun 2001 22:24:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:64663 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263934AbRFDCY2>;
	Sun, 3 Jun 2001 22:24:28 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15130.61778.471925.245018@pizda.ninka.net>
Date: Sun, 3 Jun 2001 19:24:18 -0700 (PDT)
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: multicast hash incorrect on big endian archs
In-Reply-To: <3B1A9558.2DBAECE7@colorfullife.com>
In-Reply-To: <3B1A9558.2DBAECE7@colorfullife.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Manfred Spraul writes:
 > I noticed that the multicast hash calculations assumed little endian
 > byte ordering in the winbond-840 driver, and it seems that several other
 > drivers are also affected:
 > 
 > 8139too, epic100, fealnx, pci-skeleton, sis900, starfile, sundance,
 > via-rhine, yellowfin
 > perhaps drivers/net/pcmcia/xircom_tulip_cb

Many big-endian systems already need to provide little-endian bitops,
for ext2's sake for example.

We should formalize this, with {set,clear,change,test}_le_bit which
technically every port has implemented in some for or another already.

Later,
David S. Miller
davem@redhat.com
