Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132991AbRD2XXS>; Sun, 29 Apr 2001 19:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132898AbRD2XXI>; Sun, 29 Apr 2001 19:23:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:31889 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132881AbRD2XXA>;
	Sun, 29 Apr 2001 19:23:00 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15084.41552.252094.184611@pizda.ninka.net>
Date: Sun, 29 Apr 2001 16:22:56 -0700 (PDT)
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: best zero-copy example?
In-Reply-To: <200104291638.f3TGcNs464321@saturn.cs.uml.edu>
In-Reply-To: <200104291638.f3TGcNs464321@saturn.cs.uml.edu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Albert D. Cahalan writes:
 > 
 > What would be the cleanest driver that does everything right?

All of 3c59x, acenic, sunhme, sungem do all of ipv4 right.

sunhme and sungem get ipv6 right as well because they just treat the
checksummed area as an opaque buffer, whereas the other chips really
do checksummming in an ipv4 specific way.

You can check for this "ipv4 only checksumming" feature attribute
being set in the driver, via NETIF_F_IP_CSUM.

The smarter chips which checksum in a protocol independant way will
use NETIF_F_HW_CSUM.

Later,
David S. Miller
davem@redhat.com
