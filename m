Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbVHVVKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVHVVKE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbVHVVJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:09:41 -0400
Received: from outmx019.isp.belgacom.be ([195.238.2.200]:39313 "EHLO
	outmx019.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1751207AbVHVVJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:09:37 -0400
Message-ID: <430A3F55.7090909@246tNt.com>
Date: Mon, 22 Aug 2005 23:10:45 +0200
From: Sylvain Munaut <tnt@246tNt.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050610)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Obtaining official minor device number : How ? (tried device@lanana.org,
 no answer)
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'd like to obtain some minor device number and I'm not sure how to do
so. I've seen that a request must be sent to device@lanana.org, and I've
done it, following the instructions (I think). I've sent it twice, a
first time two month ago, then again a little less than a month ago.
Each time with no anwer ;(

Here is the mail I sent each time (greeting & thanks snipped) :

----<CUT>----
I'd like to obtain an official range in the low-density serial port
(major=204) for the serial ports on the SoC MPC5200. This chip has 6 PSC
that can act as serial port. I'd suggest naming them ttyPSC[0-5] and
just using "PPC PSC - port n" as decription since freescale might decide
to reuse the PSC for future chips in the same family.

Something like that I'd guess

                 148 = /dev/ttyPSC0              PPC PSC - port 0
                    ...
                 153 = /dev/ttyPSC5              PPC PSC - port 5


Currently the driver (drivers/serial/mpc52xx_uart.c) uses the "standard"
/dev/ttySx but that causes conflicts when for example a pcmcia serial
card is present since both driver want the same serial. Apparently the
"low density serial port" major is there for theses kind of ports so  ;)
----<CUT>----


Is there some critical information missing ? Something I don't get ?



	Sylvain
