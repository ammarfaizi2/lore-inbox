Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316901AbSEVJhK>; Wed, 22 May 2002 05:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316909AbSEVJhJ>; Wed, 22 May 2002 05:37:09 -0400
Received: from maillog.promise.com.tw ([210.244.60.166]:5902 "EHLO
	maillog.promise.com.tw") by vger.kernel.org with ESMTP
	id <S316901AbSEVJhH>; Wed, 22 May 2002 05:37:07 -0400
Message-ID: <015a01c20174$654acbf0$c0cca8c0@promise.com.tw>
From: "Hank Yang" <hanky@promise.com.tw>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        <torvalds@transmeta.com>, <arjanv@redhat.com>
In-Reply-To: <E16lBmI-0006nf-00@the-village.bc.nu>
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
Date: Wed, 22 May 2002 17:38:13 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alan.

    Have you been modify the part of pdc202xx.c we mention last time?
And I have another issue to ask you modify. Could you please modify
pdc202xx.c to append "QUANTUM FIREBALLP KA9.1" for mark quirk
drives.

const char *pdc_quirk_drives[] = {
 "QUANTUM FIREBALLlct08 08",
 "QUANTUM FIREBALLP KA6.4",
 "QUANTUM FIREBALLP KA9.1",     //please append this line
 "QUANTUM FIREBALLP LM20.4",
 "QUANTUM FIREBALLP KX20.5",
 "QUANTUM FIREBALLP KX27.3",
 "QUANTUM FIREBALLP LM20.5",
 NULL
};

If any other questions about Promise products,
Please feel free to mail support@promise.com or support@promise.com.tw
Don't reply me directly.
Thanks and Regards
Hank Yang

----- Original Message -----
From: Alan Cox
To: Hank Yang
Cc: Alan Cox ; linux-kernel@vger.kernel.org ; torvalds@transmeta.com ;
arjanv@redhat.com
Sent: 2002?3?14? ?? 12:39
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch


>     The patch-file 'patch-2.4.19-pre2-ac3' needs be modified for
pdc202xx.c.
> In pdc202xx.c, pdc202xx_new_tune_chipset()
> switch (speed) to set timing only when UDMA 6 drives exist on ATA-133
> controller (PDC20269 and PDC20275). If there are no any UDMA 6 drives
> exists, we don't need to set timing here.
>
>     Would you please modify this part?

I'll try and work out the bit you need merging

