Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132606AbQLHU5B>; Fri, 8 Dec 2000 15:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132625AbQLHU4v>; Fri, 8 Dec 2000 15:56:51 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:30227 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S132606AbQLHU4b>; Fri, 8 Dec 2000 15:56:31 -0500
Message-ID: <3A3143D5.98E8E948@Hell.WH8.TU-Dresden.De>
Date: Fri, 08 Dec 2000 21:25:57 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Ion Badulescu <ionut@cs.columbia.edu>
CC: Andrey Savochkin <saw@saw.sw.com.sg>, linux-kernel@vger.kernel.org
Subject: Re: eepro100 driver update for 2.4
In-Reply-To: <Pine.LNX.4.21.0012081130420.26353-100000@age.cs.columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:
 
> The fact that apparently only the people using 82559 chips are seeing this
> seems to confirm my analysis above.
> 
> If you could try the attached patch (and maybe pass it onto the other
> people who are experiencing this problem), that would be great.

> +               /* disable advertising the flow-control capability */
> +               sp->advertising &= ~0x0400;
> +               mdio_write(ioaddr, sp->phy[0] & 0x1f, sp->advertising);

                                                      ^^^
                                                 missing a 4 here?


I've tried the patch putting a 4 in the place noted above. It doesn't
help with the issue at all. Also interesting is the fact that my kernel
hangs upon bootup around starting syslogd/klogd or around setting up the
NIC (haven't quite figured out), if I pull the network plug and continues
when I plug it back in.

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
