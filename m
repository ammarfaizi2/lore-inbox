Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129732AbQKEDsD>; Sat, 4 Nov 2000 22:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129728AbQKEDry>; Sat, 4 Nov 2000 22:47:54 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:5907 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129723AbQKEDrs>;
	Sat, 4 Nov 2000 22:47:48 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <andrewm@uow.edu.au>, Andi Kleen <ak@suse.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "Hen, Shmulik" <shmulik.hen@intel.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'LNML'" <linux-net@vger.kernel.org>
Subject: Re: Locking Between User Context and Soft IRQs in 2.4.0 
In-Reply-To: Your message of "Sun, 05 Nov 2000 14:39:43 +1100."
             <9277.973395583@ocs3.ocs-net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 05 Nov 2000 14:47:41 +1100
Message-ID: <9368.973396061@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pressed enter too soon.

        /*
         *      Call device private open method
         */

	ret = -ENODEV;
	if (dev->open && try_inc_mod_count(dev->owner)) {
		if ((ret = dev->open(dev)) && dev->owner)
			__MOD_DEC_USE_COUNT(dev->owner);
	}


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
