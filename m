Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262988AbRFJWYB>; Sun, 10 Jun 2001 18:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263011AbRFJWXv>; Sun, 10 Jun 2001 18:23:51 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:19086 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S262988AbRFJWXl>; Sun, 10 Jun 2001 18:23:41 -0400
Date: Sun, 10 Jun 2001 18:23:33 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Russell King <rmk@arm.linux.org.uk>, Andrew Morton <andrewm@uow.edu.au>,
        <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: 3C905b partial  lockup in 2.4.5-pre5 and up to 2.4.6-pre1
In-Reply-To: <3B23A4BB.7B4567A3@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0106101820350.14671-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jun 2001, Jeff Garzik wrote:
> rmk wrote:
> > [note I've not found anything in 2.4.5 where netif_carrier_ok prevents
> > the net layers queueing packets for an interface, and forwarding them
> > on for transmission].
>
> we want netif_carrier_{on,off} to emit netlink messages.  I don't know
> how DaveM would feel about such getting implemented in 2.4.x though,
> even if well tested.

There are a lot of places that make the assumption that packets
transmitted after ifconfig eth0 .... up returns will hit the wire, and
yes, anything that does make that assumption is indeed broken.  That said,
adding an extra 30s of DNS timeouts and a few more seconds of rpc timeouts
there to bootup is painful.

		-ben

