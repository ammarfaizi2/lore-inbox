Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129084AbRBIU1V>; Fri, 9 Feb 2001 15:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129176AbRBIU1M>; Fri, 9 Feb 2001 15:27:12 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:24843 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129084AbRBIU1I>;
	Fri, 9 Feb 2001 15:27:08 -0500
Message-ID: <3A84528B.388D1419@mandrakesoft.com>
Date: Fri, 09 Feb 2001 15:26:51 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ion Badulescu <ionut@cs.columbia.edu>
CC: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
        jes@linuxcare.com, Donald Becker <becker@scyld.com>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <Pine.LNX.4.30.0102091213250.31024-100000@age.cs.columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:
> ... and use both SET_MODULE_OWNER and STAR_MOD_*_USE_COUNT. It's along the
> lines of what I was thinking -- though I don't think it's very clean.

It's about the best you can do, considering the 'no ifdefs in raw'
axiom..  Better suggestions are certainly welcome.


> And one more question: is 2.2.x compatibility stuff acceptable in a 2.4
> driver, given that all that stuff is in *one* #ifdef and not sprinkled
> throughout the file?

I have no problem with such overall, as long as the 2.2 section is
self-contained and mostly out of the mainline code.

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
