Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267576AbUHUHy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267576AbUHUHy6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 03:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268888AbUHUHy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 03:54:58 -0400
Received: from qfep04.superonline.com ([212.252.122.160]:47087 "EHLO
	qfep04.superonline.com") by vger.kernel.org with ESMTP
	id S267576AbUHUHy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 03:54:56 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: "'Kalin KOZHUHAROV'" <kalin@thinrope.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
Date: Sat, 21 Aug 2004 10:54:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <cg6u22$kk$1@sea.gmane.org>
Thread-Index: AcSHUeLGRHczMugkRJiAhdKo6I9UmwACaeiA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Message-Id: <S267576AbUHUHy4/20040821075456Z+1897@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I already have rp_filter to 0 for all interfaces. It is rather a
checksumming problem than a routing one. Only if there was such an easy way
to disable checksumming as there is for solaris, disabling both the
rp_filter and the checksums would finally end the problem. The poor system
still think that it is getting the packet from 192.168.1.1 because the IP
header tells as such, while the problematic network device computes the
TCP/UDP checksum as if it is still sending it via its 192.168.77.1 source
address. There is the kernel, and the code in it which handles checksumming.
But I doubt whether a simple patch would do...

> Isn't rp_filter for this?

> A chunk of my iptables firewall script is:

> # Force route verification
> for f in /proc/sys/net/ipv4/conf/*/rp_filter; do echo 1 > $f; done

> So why don't you try:
> for f in /proc/sys/net/ipv4/conf/*/rp_filter; do echo "0" > $f; done

> Kalin.

-- 
 || ~~~~~~~~~~~~~~~~~~~~~~ ||
(  ) http://ThinRope.net/ (  )
 || ______________________ ||

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



