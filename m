Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264543AbRFKN2M>; Mon, 11 Jun 2001 09:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264545AbRFKN2D>; Mon, 11 Jun 2001 09:28:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:2450 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264543AbRFKN1u>;
	Mon, 11 Jun 2001 09:27:50 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15140.51018.942446.320621@pizda.ninka.net>
Date: Mon, 11 Jun 2001 06:27:38 -0700 (PDT)
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Russell King <rmk@arm.linux.org.uk>, Ben LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 3C905b partial  lockup in 2.4.5-pre5 and up to 2.4.6-pre1
In-Reply-To: <3B24C185.824EBBE0@uow.edu.au>
In-Reply-To: <3B23A4BB.7B4567A3@mandrakesoft.com>
	<20010610093838.A13074@flint.arm.linux.org.uk>
	<Pine.LNX.4.33.0106101201490.9384-100000@toomuch.toronto.redhat.com>
	<20010610173419.B13164@flint.arm.linux.org.uk>
	<15140.5762.589629.252904@pizda.ninka.net>
	<3B24C185.824EBBE0@uow.edu.au>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton writes:
 > It'd need to be callable from interrupt context - otherwise
 > each device/driver which has link status change interrupts
 > will need to implement some form of interrupt->process context
 > trick.

Well, we could make the netif_carrier_*() implementation do the
"interrupt->process context" trick.

Jamal can feel free to post what he has.

Later,
David S. Miller
davem@redhat.com
