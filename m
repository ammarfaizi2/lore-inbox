Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130687AbQLGOiK>; Thu, 7 Dec 2000 09:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130697AbQLGOhu>; Thu, 7 Dec 2000 09:37:50 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12811 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130634AbQLGOhf>; Thu, 7 Dec 2000 09:37:35 -0500
Subject: Re: [RFC-2] Configuring Synchronous Interfaces in Linux
To: khc@intrepid.pm.waw.pl (Krzysztof Halasa)
Date: Thu, 7 Dec 2000 14:09:19 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m33dg1141i.fsf@intrepid.pm.waw.pl> from "Krzysztof Halasa" at Dec 07, 2000 01:14:01 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1441je-0002T3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think we need few ioctl calls: get + set media (int argument),
> get + set speed (probably two - RX and TX), etc.
> In my 2.4 HDLC stuff - to be published :-( - there something like that
> (in private ioctl range, of course).

I think we are agreeing


I'm saying use something like

	struct 
	{
		u16 media_group;
		union
		{
			struct hdlc_physical ...
			struct hdlc_bitstream
			struct hdlc_protocol
			struct fr_protocol
			struct eth_physical
			struct atm_physical
			struct dsl_physical
			struct dsl_bitstream
			struct tr_physical
			struct wireless_physical
			struct wireless_80211
			struct wireless_auth
		} config;
	}

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
