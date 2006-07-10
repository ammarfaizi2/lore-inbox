Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422728AbWGJRlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422728AbWGJRlU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 13:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422730AbWGJRlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 13:41:20 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:36617 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422728AbWGJRlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 13:41:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NaRHOT2qXX9lQ3mnzJ6JKcdmtN3ioJ6+lrLog49x0sKUG3Zfh3DMV5th5Kodujl5ch6/reNBinlLR42mQyj5rg5PqfMPvnRHGlHjLn9UYQe1A2QCwA4zBbDnAnu2adB3FDPT4C+Rx3RuUCSXoCwCieuUnHdIr4zuTtsvUJ9mimI=
Message-ID: <62b0912f0607101041w69bd2a19t635a438f378e0e24@mail.gmail.com>
Date: Mon, 10 Jul 2006 19:41:19 +0200
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: "Auke Kok" <auke-jan.h.kok@intel.com>
Subject: Re: [bug] e100 bug: checksum mismatch on 82551ER rev10
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44B28C5A.5090605@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <62b0912f0607090434q735e36b7pd9ab35baf0914e7a@mail.gmail.com>
	 <44B2716A.3030009@intel.com>
	 <62b0912f0607100945o574dcce8w8f734e5828bdcaa8@mail.gmail.com>
	 <44B28C5A.5090605@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Auke Kok wrote:
> > Every single IP130 I've had my hands on has had an EEPROM that the
> > Linux driver declared bad.
>
> that means that whoever is selling you the IP130's is consistently putting on
> bad EEPROMs, which is *very* bad. Which vendor is that? They can fix this
> problem for you and for *everyone* else they have sold and will sell IP130's
> to in the future.

Nokia.

Maybe they've changed the BABA magic, or the checksum logic entirely,
to prevent other software than their own OS from running.

> > I'm afraid that it's not the board that's at fault, it's the driver.
>
> No it is not. The NIC is supported (you can even call Intel for first line
> support) but if your vendor put a bad EEPROM image on it then all bets are
> off.  Intel provides the vendors with the proper tools to make valid EEPROMs,
> the driver checks them for a very good reason.

You're completely sure that the EEPROM check is correct for this
particular revision of this particular chip?

(Do you happen to know where the EEPROM is located, by the way?
 Just out of interest.
 I can spot the three Intel chips but not the EEPROM.
 http://chrisbuechler.com/m0n0wall/nokia/images/9.png
 http://chrisbuechler.com/m0n0wall/nokia/images/11.png
 http://chrisbuechler.com/m0n0wall/nokia/images/10.png
 )

> > The NICs are working perfectly.
>
> How can you tell? Do you know if jumbo frames work correctly?  Is the device
> properly checksumming? is flow control working properly?  These and many, many
> more settings are determined by the EEPROM.  Seemingly it may work correctly,
> but there is no guarantee whatsoever that it will work correctly at all if the
> checksum is bad.  Again, you can lose data, or worse, you could corrupt memory
> in the system causing massive failure (DMA timings, etc). Unlikely? sure, but
> not impossible.

They've been used in production environments for years.

> > (Also, it seems mighty odd to refuse to drive the hardware based on an
> > EEPROM checksum failure, when the e100 driver will happily load for a
> > device where for example IRQ routing is broken.  Just another
> > indication that erroring out in this situation is overkill.)
>
> That is another discussion.  All wifi drivers bail out if the firmware is
> corrupted, why shouldn't e1000 be allowed to do so either? Are you willing to
> risk your data?

Yes.
Perhaps an "ignorechecksum" switch would be appropriate.
I'd like to hear from anyone else who has IP130s and are experiencing
this problem (or isn't!).
