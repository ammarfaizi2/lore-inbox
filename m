Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129663AbRCCSxh>; Sat, 3 Mar 2001 13:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129664AbRCCSxR>; Sat, 3 Mar 2001 13:53:17 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:54217 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S129663AbRCCSxG>;
	Sat, 3 Mar 2001 13:53:06 -0500
Message-ID: <3AA13D8F.404DC635@mandrakesoft.com>
Date: Sat, 03 Mar 2001 13:53:03 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: [patch] 2.4.2 Advantech WDT driver
In-Reply-To: <E14ZCEl-0001xd-00@mm.amelek.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marek Michalkiewicz wrote:
> 
> > Why is lock_kernel necessary?
> 
> Well, it is there in 2.4.2 acquirewdt.c (which this driver is based on -
> really only minimal changes, the hardware is only slightly different).
> I can remove it if you tell me it's really not necessary.

Sounds like it got caught in an audit and is necessary, I didn't look
closely...


> > > +       spin_lock_init(&advwdt_lock);
> > > +       misc_register(&advwdt_miscdev);
> >
> > check return code for error
> 
> Again, acquirewdt.c doesn't do it with the misc_register, request_region
> and register_reboot_notifier calls.  (Should it?  Cc: Alan Cox)

Yes, the return codes should be checked.  :)

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
