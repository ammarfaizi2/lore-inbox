Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271626AbRHUJ77>; Tue, 21 Aug 2001 05:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271625AbRHUJ7u>; Tue, 21 Aug 2001 05:59:50 -0400
Received: from miranda.axis.se ([193.13.178.2]:50882 "EHLO miranda.axis.se")
	by vger.kernel.org with ESMTP id <S271626AbRHUJ7h>;
	Tue, 21 Aug 2001 05:59:37 -0400
Message-ID: <256301c12a27$fb198790$0a070d0a@axis.se>
From: "Johan Adolfsson" <johan.adolfsson@axis.com>
To: "Martin Dalecki" <dalecki@evision-ventures.com>,
        "Richard Gooch" <rgooch@ras.ucalgary.ca>
Cc: "Theodore Tso" <tytso@mit.edu>,
        "Alex Bligh - linux-kernel" <linux-kernel@alex.org.uk>,
        "Johan Adolfsson" <johan.adolfsson@axis.com>,
        "Robert Love" <rml@tech9.net>, "Oliver Xymoron" <oxymoron@waste.org>,
        <linux-kernel@vger.kernel.org>, <riel@conectiva.com.br>
In-Reply-To: <3B80EADC.234B39F0@evision-ventures.com>	<2248596630.998319423@[10.132.112.53]>	<3B811DD6.9648BE0E@evision-ventures.com>	<20010820211107.A20957@thunk.org> <200108210136.f7L1aa008756@vindaloo.ras.ucalgary.ca> <3B822D2E.69D4380A@evision-ventures.com>
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
Date: Tue, 21 Aug 2001 11:59:34 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin Dalecki wrote:
> I don't think that it's unsufficient. In fact I think that it just
> doesn't have to be done all inside the kernel. And I oppose further
extending
> the places where the event gathering code goes in between.

As Alex said, since applications expect it to be there I see no reason to
remove it.


> BTW> There is one strong flaw in the resoning behing this whole entropy
> stuff.
>
> Iff you trust the cryptographic algorithm for the one way function you
> are using then if you initialize it once - there will be only one chance
for
> an attacker to tamper with the values. The possibility
> for tampering with it will have a certain value, which remains CONSTANT
> over the time. You could call it: breaking risk as well.

Since the boot process is predictable, it would be much easier for an
attacker to set up an identical setup and it would be no problem at all to
predict the random sequence. Then it would probably be easy to
do a DoS attack forcing the system to reboot and then break in.

> If you continuously reinitialize your one way function, the propabilitie
> to tamper with them will ADD (of course not in pure arithmetic terms).
> An attacer simply get's multiple chances. And therefore the overall
> propability of tampering
> with the values delivered to the user by this device WILL INCREASE.
>
> Multiple initializations help only against cryptographic attacks - but
> THEY HURT
> overall security of the system, becouse they "open it up".
>
> So this is indeed a serious FLAW inside the logics behind the
> implementation of this device.

This sounds bogus to me..;-)
I don't buy it!

/Johan


