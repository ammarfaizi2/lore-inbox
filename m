Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313005AbSDCCOc>; Tue, 2 Apr 2002 21:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312989AbSDCCOX>; Tue, 2 Apr 2002 21:14:23 -0500
Received: from adsl-67-113-154-34.dsl.sntc01.pacbell.net ([67.113.154.34]:28910
	"EHLO postbox.aslab.com") by vger.kernel.org with ESMTP
	id <S312951AbSDCCON>; Tue, 2 Apr 2002 21:14:13 -0500
Message-ID: <15b401c1dab4$7bf2c240$6502a8c0@jeff>
From: "Jeff Nguyen" <jeff@aslab.com>
To: "Trent Piepho" <xyzzy@speakeasy.org>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <jim@rubylane.com>, <linux-kernel@vger.kernel.org>,
        <linux-raid@vger.kernel.org>
In-Reply-To: <E16sZPj-0002vm-00@the-village.bc.nu>
Subject: Re: Update on Promise 100TX2 + Serverworks IDE issues -- 2.2.20
Date: Tue, 2 Apr 2002 18:08:44 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are ATAPI devices using UDMA25 such as HP 9300i. These UDMA25
devices are the problem maker on OSB4. Unless DMA is disabled, the system
will lock up when accessing the drive.

If you have UDMA33 ATAPI devices, they work great in OSB4.

Jeff

----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "Trent Piepho" <xyzzy@speakeasy.org>
Cc: <jim@rubylane.com>; <linux-kernel@vger.kernel.org>;
<linux-raid@vger.kernel.org>
Sent: Tuesday, April 02, 2002 5:18 PM
Subject: Re: Update on Promise 100TX2 + Serverworks IDE issues -- 2.2.20


> > I think the serverworks IDE is only mode4, not even UDMA33.  I heard a
lot of
> > bad things about it, and removed all the IDE drives from our serverworks
> > system's controller.
>
> Serverworks OSB4 IDE will do UDMA33 but seems to have problems with
certain
> combinations of drives, controllers and unknown influences. The newer CSB5
> seems to work beautifully
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

