Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbQLSWUp>; Tue, 19 Dec 2000 17:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129458AbQLSWUg>; Tue, 19 Dec 2000 17:20:36 -0500
Received: from mail.valinux.com ([198.186.202.175]:29971 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129525AbQLSWUF>;
	Tue, 19 Dec 2000 17:20:05 -0500
Date: Tue, 19 Dec 2000 13:51:14 -0800
From: David Hinds <dhinds@valinux.com>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCMCIA modem (v.90 X2) not working with 2.4.0-test12 PCMCIA services
Message-ID: <20001219135114.B13184@valinux.com>
In-Reply-To: <007101c067cc$0500c620$0b31a3ce@g1e7m6> <20001218154033.C11728@valinux.com> <20001219114614.A12948@valinux.com> <20001219154129.A1763@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.6i
In-Reply-To: <20001219154129.A1763@vger.timpanogas.org>; from Jeff V. Merkey on Tue, Dec 19, 2000 at 03:41:29PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2000 at 03:41:29PM -0700, Jeff V. Merkey wrote:
> 
> On a related topic, the 3c575_cb driver on an IBM Thinkpad 765D is getting
> tx errors on the 2.2.18 kernel with PCMCIA services 3.1.22.
> 
> Card is a 3Com 3CCFE575BT Cyclone Cardbus Adapter.
> 
> Error is:
> 
> eth0:  transmit timed out, tx_status 00 status e000.
>   diagnostics net 0cc2 media a800 dma 000000a0

What host bridge is in the 765D?  Is it perhaps a TI 1131 rev 1, or
something else?  Also, try adding:

  module "3c575_cb" opts "down_poll_rate=0"

to /etc/pcmcia/config.opts and see if that makes any difference.

-- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
