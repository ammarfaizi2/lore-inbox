Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129961AbQKFS7L>; Mon, 6 Nov 2000 13:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129850AbQKFS7B>; Mon, 6 Nov 2000 13:59:01 -0500
Received: from kogge.hanse.de ([192.76.134.17]:8456 "EHLO kogge.Hanse.DE")
	by vger.kernel.org with ESMTP id <S129543AbQKFS6p>;
	Mon, 6 Nov 2000 13:58:45 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: "ip_dynaddr" broken in 2.4.0-test10
In-Reply-To: <3A064279.30960692@egu.schule.ulm.de> <200011060522.VAA23103@pizda.ninka.net> <3A064B01.E8DCC9E3@egu.schule.ulm.de>
From: Henner Eisen <eis@baty.hanse.de>
Date: 06 Nov 2000 19:39:36 +0100
In-Reply-To: Steffen Moser's message of "Mon, 06 Nov 2000 07:09:05 +0100"
Message-ID: <ouk8ahgd1z.fsf@baty.hanse.de>
X-Mailer: Gnus v5.5/Emacs 20.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> "Steffen" == Steffen Moser <moser@egu.schule.ulm.de> writes:

    >> Does this fix it?
    >>
    >> echo "1" >/proc/sys/net/ipv4/ip_nonlocal_bind

    Steffen> I tried this - but no success. The problem persists...

I just wrote a tool that does re-sending and address-rewriting
of the first packet from user space. If the bug is that ip_dynaddr fails
to re-send the first packet, the tool should work around this and thus
be a good diagnostic aid. (And BTW, it also works around other
`first packet lost' problems that are not handled by ip_dynaddr like
lost DNS lookup). See http://www.baty.hanse.de/ip_resend/ip_resend-0.3.tar.gz

Henner
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
