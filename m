Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282481AbRKZUcy>; Mon, 26 Nov 2001 15:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282482AbRKZUcl>; Mon, 26 Nov 2001 15:32:41 -0500
Received: from mail110.mail.bellsouth.net ([205.152.58.50]:21490 "EHLO
	imf10bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S282481AbRKZUcV>; Mon, 26 Nov 2001 15:32:21 -0500
Message-ID: <3C02A6D0.58AE0FEE@mandrakesoft.com>
Date: Mon, 26 Nov 2001 15:32:16 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.15-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Anders Linden <anli@perceptive.se>, linux-kernel@vger.kernel.org
Subject: Re: Network card timeouts
In-Reply-To: <E168SKg-0006jd-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > The later card, Davicom, is probably not a well-known card, but
> > nevertheless, it works like shit in Linux. I am using Redhat 7.1 and th=
> > e
> > kernel 2.4.2-2. If I send more than 10M to such a card in an interval o=
> 
> Davicom is a bad tulip clone. It has a (not very good) davicom provided
> driver in 2.4.2 or you can use tulip or the updated davicom provided dfme
> driver in newer 2.4

tulip should work better IMHO for all davicom tulip clones -except- the
older ones which require doing a software crc for each packet.  For
those, the performance penalty is too high to integrate into the
mainline tulip driver.  So my advice is usually "try tulip, then
fallback to dmfe if software crc is required"

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

