Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130043AbQKGMhh>; Tue, 7 Nov 2000 07:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130024AbQKGMh2>; Tue, 7 Nov 2000 07:37:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45944 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129832AbQKGMhP>; Tue, 7 Nov 2000 07:37:15 -0500
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
To: jas88@cam.ac.uk (James A. Sutherland)
Date: Tue, 7 Nov 2000 12:35:19 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jas88@cam.ac.uk (James A. Sutherland),
        goemon@anime.net (Dan Hollis), dwmw2@infradead.org (David Woodhouse),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        oxymoron@waste.org (Oliver Xymoron), kaos@ocs.com.au (Keith Owens),
        linux-kernel@vger.kernel.org
In-Reply-To: <00110712163100.01343@dax.joh.cam.ac.uk> from "James A. Sutherland" at Nov 07, 2000 12:13:08 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13t7yE-0007MV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In the NIC example, I might well want the DHCP client to run whenever I
> activate the card. Bringing the NIC up with the old configuration - which, with
> dynamic IP addresses, could now include someone else's IP address! - is worse
> than useless.

You'll notice the pcmcia subsystem already handles this, and keeps data in user
space although it doesnt support saving it back. And it all works

In your case it would be something like

eth0	pegasus
nopersist eth0
post-install eth0 /usr/local/sbin/my-dhcp-stuff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
