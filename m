Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129867AbQLCL6x>; Sun, 3 Dec 2000 06:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129909AbQLCL6n>; Sun, 3 Dec 2000 06:58:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62726 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129867AbQLCL6g>;
	Sun, 3 Dec 2000 06:58:36 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200012031127.eB3BRm531079@flint.arm.linux.org.uk>
Subject: Re: [RFC] Configuring synchronous interfaces in Linux
To: philb@gnu.org (Philip Blundell)
Date: Sun, 3 Dec 2000 11:27:47 +0000 (GMT)
Cc: cw@f00f.org (Chris Wedgwood), linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
In-Reply-To: <E142X2p-0003Kc-00@kings-cross.london.uk.eu.org> from "Philip Blundell" at Dec 03, 2000 11:10:59 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(CC list trimmed)

Philip Blundell writes:
> >Does it? At which point? To me it looks like it calls dev->do_ioctl
> >or am I missing something?
> 
> It uses SIOCSIFMAP, which (I think) winds up in dev.c here:
> 
> 	case SIOCSIFMAP:
> 			if (dev->set_config) {
> 				if (!netif_device_present(dev))
> 					return -ENODEV;
> 				return dev->set_config(dev,&ifr->ifr_map);
> 			}
> 			return -EOPNOTSUPP;

It definitely does end up there.  However, the ethtool ioctls end up
in dev->do_ioctl.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
