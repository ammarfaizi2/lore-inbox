Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129908AbQLCLyw>; Sun, 3 Dec 2000 06:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129909AbQLCLym>; Sun, 3 Dec 2000 06:54:42 -0500
Received: from tazenda.demon.co.uk ([158.152.220.239]:4356 "EHLO
	tazenda.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129908AbQLCLyg>; Sun, 3 Dec 2000 06:54:36 -0500
X-Mailer: exmh version 2.1.1 10/15/1999 (debian)
To: Chris Wedgwood <cw@f00f.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        Donald Becker <becker@scyld.com>, Francois Romieu <romieu@cogenit.fr>,
        Russell King <rmk@arm.linux.org.uk>, Ivan Passos <lists@cyclades.com>,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [RFC] Configuring synchronous interfaces in Linux 
In-Reply-To: Message from Chris Wedgwood <cw@f00f.org> 
   of "Sun, 03 Dec 2000 18:47:12 +1300." <20001203184712.C1630@metastasis.f00f.org> 
In-Reply-To: <Pine.LNX.3.96.1001202130202.1450B-100000@mandrakesoft.mandrakesoft.com> <jgarzik@mandrakesoft.mandrakesoft.com> <E142IrA-0007hG-00@kings-cross.london.uk.eu.org>  <20001203184712.C1630@metastasis.f00f.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 03 Dec 2000 11:10:59 +0000
From: Philip Blundell <philb@gnu.org>
Message-Id: <E142X2p-0003Kc-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Does it? At which point? To me it looks like it calls dev->do_ioctl
>or am I missing something?

It uses SIOCSIFMAP, which (I think) winds up in dev.c here:

	case SIOCSIFMAP:
			if (dev->set_config) {
				if (!netif_device_present(dev))
					return -ENODEV;
				return dev->set_config(dev,&ifr->ifr_map);
			}
			return -EOPNOTSUPP;
	
p.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
