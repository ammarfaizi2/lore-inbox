Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265140AbTLWNlo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 08:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbTLWNlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 08:41:44 -0500
Received: from bay8-dav38.bay8.hotmail.com ([64.4.26.95]:56336 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S265140AbTLWNlm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 08:41:42 -0500
X-Originating-IP: [194.236.130.199]
X-Originating-Email: [nikomail@hotmail.com]
From: "Nicklas Bondesson" <nikomail@hotmail.com>
To: "'Walt H'" <waltabbyh@comcast.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Error mounting root fs on 72:01 using Promise FastTrak TX2000 (PDC20271)
Date: Tue, 23 Dec 2003 14:41:42 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <3FE7BAC4.2040901@comcast.net>
Thread-Index: AcPJB7hF61wBTlK1TVCizY1/OfJoLwAUk2Cg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY8-DAV38oZFhIug1f000116c4@hotmail.com>
X-OriginalArrivalTime: 23 Dec 2003 13:41:41.0415 (UTC) FILETIME=[7F292B70:01C3C95A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Finally got it to work!

There must be a bug causing the Promise card / driver not to be fired up
(i'm using ab ASUS P2B motheroard). If I issue the "acpi=off" to the kernel
at boot it detects the card and fires up the driver. Everything seems to
work now. Who should I post this bug to so it can be fixed in coming
releases?

/Nicke

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Walt H
Sent: den 23 december 2003 04:47
To: Nicklas Bondesson
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error mounting root fs on 72:01 using Promise FastTrak TX2000
(PDC20271)

Nicklas Bondesson wrote:
> The patch did not work for me, in fact there was no change at all 
> (anything affected to me). The Promise ataraid driver never gets loaded.
> 
> /Nicke

Not sure what else to try. I see that you've already posted to the ata-raid
list, so I'd hope that somebody else would reply from there. The pdcraid
driver has not received much attention lately, so it may very well be broken
for your configuration. Promise has released a binary/source combo driver
similar to Nvidia's that will still work in 2.4 - you might give that a try.
I have a
PDC20276 based onboard raid setup, however, I use 2.6 with device mapper to
use it. It's a bit of a pain to setup ATM - especially if you want to boot
from it, but it can be done. Good luck,

-Walt


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
