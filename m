Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264071AbRFNVgM>; Thu, 14 Jun 2001 17:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264080AbRFNVf4>; Thu, 14 Jun 2001 17:35:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:11956 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264071AbRFNVf2>;
	Thu, 14 Jun 2001 17:35:28 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15145.11801.823664.36512@pizda.ninka.net>
Date: Thu, 14 Jun 2001 14:35:21 -0700 (PDT)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Tom Gall <tom_gall@vnet.ibm.com>
Subject: Re: Going beyond 256 PCI buses
In-Reply-To: <20010614213021.3814@smtp.wanadoo.fr>
In-Reply-To: <15145.6960.267459.725096@pizda.ninka.net>
	<20010614213021.3814@smtp.wanadoo.fr>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Benjamin Herrenschmidt writes:
 > I beleive there will always be need for some platform specific
 > hacking at probe-time to handle those, but we can at least make
 > the inx/outx functions/macros compatible with such a scheme,
 > possibly by requesting an ioremap equivalent to be done so that
 > we stop passing them real PIO addresses, but a cookie obtained
 > in various platform specific ways.

The cookie can be encoded into the address itself.

This is why readl() etc. take one arg, the address, not a billion
other arguments like some systems do.

Later,
David S. Miller
davem@redhat.com
