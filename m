Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129874AbQKPQ4M>; Thu, 16 Nov 2000 11:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130112AbQKPQ4C>; Thu, 16 Nov 2000 11:56:02 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:24851 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129874AbQKPQzy>; Thu, 16 Nov 2000 11:55:54 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14868.2681.414826.48776@wire.cadcamlab.org>
Date: Thu, 16 Nov 2000 10:25:29 -0600 (CST)
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: PCI configuration changes
In-Reply-To: <200011161605.RAA23133@green.mif.pg.gda.pl>
	<3A140752.68E11210@mandrakesoft.com>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Jeff Garzik <jgarzik@mandrakesoft.com>]
> For drivers that are 100% MCA, they do not need to test MCA_bus,
> because that test can be done in Config.in.

I think Andrzej was concerned with a driver assuming that just because
CONFIG_MCA is defined, there *is* an MCA bus on the machine.  This is
of course an invalid assumption.  I will try to make sure that the
driver init in each case has something like

	if (!MCA_bus)
		return -ENODEV;

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
