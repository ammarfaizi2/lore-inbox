Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136597AbREGSft>; Mon, 7 May 2001 14:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136600AbREGSfa>; Mon, 7 May 2001 14:35:30 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:24842 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S136597AbREGSfT>; Mon, 7 May 2001 14:35:19 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: David Woodhouse <dwmw2@infradead.org>
cc: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Message-ID: <86256A45.0066044D.00@smtpnotes.altec.com>
Date: Mon, 7 May 2001 13:34:31 -0500
Subject: Re: [Solved ?] Re: pcmcia problems after upgrading from 2.4.3-ac7
	 to 2.4.4
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The thing that confused me here was the help text in menuconfig.  The help for
CONFIG_I82365 says, "Say Y here to include support for PCMCIA and CardBus host
bridges that are register compatible with the Intel i82365 and/or the Yenta
specification: this includes virtually all modern PCMCIA bridges."  Also, the
help text for both this option and CONFIG_CARDBUS say, "If unsure, say Y," so I
selected both of them.  It wasn't until Jeff Garzik set me straight recently
that I began disabling CONFIG_I82365 and using CONFIG_CARDBUS alone.

Wayne




David Woodhouse <dwmw2@infradead.org> on 05/07/2001 03:58:00 AM

To:   "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
cc:   Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org (bcc:
      Wayne Brown/Corporate/Altec)

Subject:  Re: [Solved ?] Re: pcmcia problems after upgrading from 2.4.3-ac7 to
      2.4.4




Martin.Knoblauch@TeraPort.de said:
>
>   I am not sure whether this should be closed alltogether. Maybe
> i82365 was not the proper choice for my hardware in the first place.
> Anyway, the module seems to be retired as of 2.4.3-ac10/ac11. Maybe a
> hint should go into the changes document.

i82365 is for use only on PCMCIA bridges, not CardBus. It should not be
'retired' but should probably have the config option renamed to prevent
confusion.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/





