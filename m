Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130887AbRAKByz>; Wed, 10 Jan 2001 20:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131333AbRAKByp>; Wed, 10 Jan 2001 20:54:45 -0500
Received: from palrel1.hp.com ([156.153.255.242]:50436 "HELO palrel1.hp.com")
	by vger.kernel.org with SMTP id <S130887AbRAKByg>;
	Wed, 10 Jan 2001 20:54:36 -0500
Message-Id: <200101110156.RAA05928@milano.cup.hp.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: andre@linux-ide.org (Andre Hedrick), linux-kernel@vger.kernel.org,
        taggart@fc.hp.com, m.ashley@unsw.edu.au
Subject: Re: [PATCH] 2.2.18pre21 ide-disk.c for OB800 
In-Reply-To: Your message of "Thu, 11 Jan 2001 01:33:08 PST."
             <E14GWc2-0001QZ-00@the-village.bc.nu> 
Date: Wed, 10 Jan 2001 17:56:08 -0800
From: Grant Grundler <grundler@cup.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andre, Alan,
My grand total experience with IDE drivers is now around 4 hours.
I have no clue what's right or wrong and am quite clueless what the
role of apmd is wrt ide-disk driver. I'm open to testing other fixes
for this problem.

AFAIK, this could be a BIOS bug since no one else seems to have run into
on other laptops and it's reproduce with two different makes of drives. 

The reason I put the fix in the read/multwrite_intr path is the recovery
has to occur before the I/O is retried and before accessing the disk.
If multmode can be set before even trying the I/O, then that's definitely
a better solution. I just have no clue how to implement it.

thanks,
grant

Grant Grundler
Unix Systems Enablement Lab
+1.408.447.7253
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
