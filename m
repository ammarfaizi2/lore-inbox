Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130437AbRBIUL6>; Fri, 9 Feb 2001 15:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130529AbRBIULs>; Fri, 9 Feb 2001 15:11:48 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:1291 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S130533AbRBIULn>;
	Fri, 9 Feb 2001 15:11:43 -0500
Message-ID: <3A844EDB.7F1CA6BE@mandrakesoft.com>
Date: Fri, 09 Feb 2001 15:11:07 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ion Badulescu <ionut@cs.columbia.edu>
CC: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
        jes@linuxcare.com, Donald Becker <becker@scyld.com>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <Pine.LNX.4.30.0102091204560.31024-100000@age.cs.columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:
> On Fri, 9 Feb 2001, Jeff Garzik wrote:
> > BTW, I would suggest looking at Jes' acenic.c as an example of a 2.4
> > driver that is clean but also [hopefully!] works under 2.2.
> 
> The *only* thing I couldn't solve cleanly is the MOD_{INC,DEC}_USE_COUNT
> vs MODULE_SET_OWNER(). And I would really appreciate pointers for that. :)

For 2.2, define SET_MODULE_OWNER to null.

Define STAR_MOD_INC_USE_COUNT and STAR_MOD_DEC_USE_COUNT.  For 2.4,
these are null.  For 2.2, these point to MOD_{INC,DEC}_USE_COUNT.

	Jeff



-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
