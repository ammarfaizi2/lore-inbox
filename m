Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274779AbRIUSpi>; Fri, 21 Sep 2001 14:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274778AbRIUSp2>; Fri, 21 Sep 2001 14:45:28 -0400
Received: from hermes.toad.net ([162.33.130.251]:42722 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S274779AbRIUSpR>;
	Fri, 21 Sep 2001 14:45:17 -0400
Message-ID: <3BAB8AB2.C6DB27B0@yahoo.co.uk>
Date: Fri, 21 Sep 2001 14:45:06 -0400
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parport_pc.c PnP BIOS sanity check
In-Reply-To: <Pine.LNX.4.33.0109210209520.21008-100000@terbidium.openservices.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the replies.

I'd like to underline Alan Cox's reply that DMA0 _is_ usable.
In fact, my sound chip is configured to use DMA0.

If (and only if) parport _cannot_ use DMA0 for some reason
then the sanity check is justified.  In that case I'd just ask
that a short comment be added to the code that gives the reason.

Cheers
Thomas

Ignacio Vazquez-Abrams wrote:
> DMA0 is reserved for memory refresh. It _can't_ be used for anything else,
> therefore a value of 0 is representative of no value whatsoever.

Alan Cox wrote:
> This has been unsafe since about 1995, when DMA 0 became available as PC's
> stopped using the ISA DMA engine for memory refresh (a very neat original PC
> hack)

Gunther Mayer wrote:
> 1)
>   I think I saw some BIOS report DMA0 for "none" (could even have
>   been ACPI which is returning PNP formatted legacy resource data).
> 2)
>   I have never seen DMA0 for parport configured by a BIOS.
> 3)
>   Try "lssuperio" if you want the real hardware thing.
> 
> This qualifies the code as it is as a sanity check.
