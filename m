Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbRAWHqH>; Tue, 23 Jan 2001 02:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129710AbRAWHp4>; Tue, 23 Jan 2001 02:45:56 -0500
Received: from WARSL401PIP5.highway.telekom.at ([195.3.96.112]:1579 "HELO
	email03.aon.at") by vger.kernel.org with SMTP id <S129631AbRAWHpo>;
	Tue, 23 Jan 2001 02:45:44 -0500
From: "Michael Guntsche" <m.guntsche@epitel.at>
To: <linux-kernel@vger.kernel.org>
Subject: AGPGART problems with VIA KX133 chipsets under 2.2.18/2.4.0
Date: Tue, 23 Jan 2001 08:33:25 +0100
Message-ID: <NDBBJOKGIPCDBEEFHNFPGECPCAAA.m.guntsche@epitel.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all,

While playing around with the agpgart module I noticed the following strange
behaviour.

The hardware in question is an Asus K7V with the KX133 chipset and has been
tested on both 2.4.0 and 2.2.18 kernels.

The output below is just from insmod,rmmod,insmod agpgart without starting
X.

insmod agpgart for the first time:
Jan 22 23:17:10 deepblue kernel: Linux agpgart interface v0.99 (c) Jeff
Hartmann
Jan 22 23:17:10 deepblue kernel: agpgart: Maximum main memory to use for agp
memory: 204M
Jan 22 23:17:10 deepblue kernel: agpgart: Detected Via Apollo Pro chipset
Jan 22 23:17:10 deepblue kernel: agpgart: AGP aperture is 64M @ 0xe4000000
                                                                  ^-------

rmmod, insmod agpgart:
Jan 22 23:17:16 deepblue kernel: Linux agpgart interface v0.99 (c) Jeff
Hartmann
Jan 22 23:17:16 deepblue kernel: agpgart: Maximum main memory to use for agp
memory: 204M
Jan 22 23:17:16 deepblue kernel: agpgart: Detected Via Apollo Pro chipset
Jan 22 23:17:16 deepblue kernel: agpgart: AGP aperture is 64M @ 0x4000000
                                                                  ^------
Apparently AGP isnt working afterwards.
Someone know what might be causing this?


If you need more information or a want me to help debug this issue further
dont hestitate to tell me.

Since Im not subscribed to the list, please CC any replies to me directly.




Cheers,
Mike


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
