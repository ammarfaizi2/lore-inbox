Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQLGHX7>; Thu, 7 Dec 2000 02:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129385AbQLGHXt>; Thu, 7 Dec 2000 02:23:49 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:55821 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S129319AbQLGHXi>;
	Thu, 7 Dec 2000 02:23:38 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: [RFC-2] Configuring Synchronous Interfaces in Linux
In-Reply-To: <E143THN-0000A1-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
From: Krzysztof Halasa <khc@intrepid.pm.waw.pl>
Date: 07 Dec 2000 01:14:01 +0100
In-Reply-To: Alan Cox's message of "Wed, 6 Dec 2000 01:21:52 +0000 (GMT)"
Message-ID: <m33dg1141i.fsf@intrepid.pm.waw.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Generic is not always good , thats why we have SIOCDEVPRIVATE. One thing Im
> pondering is if we should make the hardware config ioctl take a hardware type
> ident with each struct. That would help make all the ethernet agree, all the
> wan agree, all the ADSL agree without making a nasty mess.

What's wrong with returning -Exxx error code when the user requests
unsupported interface or function?

I think we should just #define possible values in standard include file
and make ifconfig/ip use it. We can add additional media types as
required.

2.5 task IMHO.

I think we need few ioctl calls: get + set media (int argument),
get + set speed (probably two - RX and TX), etc.
In my 2.4 HDLC stuff - to be published :-( - there something like that
(in private ioctl range, of course).
-- 
Krzysztof Halasa
Network Administrator
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
