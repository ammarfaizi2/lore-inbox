Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131038AbQKVMSx>; Wed, 22 Nov 2000 07:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130900AbQKVMSo>; Wed, 22 Nov 2000 07:18:44 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:44283 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S131468AbQKVMSZ>;
	Wed, 22 Nov 2000 07:18:25 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3A1BAF5F.4649594B@uow.edu.au> 
In-Reply-To: <3A1BAF5F.4649594B@uow.edu.au>  <3A1BAC59.B0F124AF@uow.edu.au>, <3A1BAC59.B0F124AF@uow.edu.au> <20001121142616.L7764@sventech.com>, <20001121142616.L7764@sventech.com> <20001121095626.F3431@valinux.com> <Pine.LNX.4.30.0011211912490.22252-100000@imladris.demon.co.uk> <4627.974890115@redhat.com> <9719.974892360@redhat.com> 
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Johannes Erdfelt <johannes@erdfelt.com>,
        Oleg Drokin <green@ixcelerator.com>, linux-kernel@vger.kernel.org
Subject: Re: hardcoded HZ in hub.c 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Date: Wed, 22 Nov 2000 11:47:38 +0000
Message-ID: <11991.974893658@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


andrewm@uow.edu.au said:
>  Ah.  No, I don't think it would be polite to cause TTY hangup
> processing to be deferred for this long.  I'd suggest that the policy
> be "scheduled tasks can't sleep".  I guess kmalloc(GFP_KERNEL) is
> acceptable because the system is already running like a dog if this
> sleeps.

Oi! I specifically added that so I could queue tasks which can sleep.

Put a time limit on it if you must, but not one which prohibits the 
existing usage by the PCMCIA socket drivers.

I'm beginning to think that I should have argued with Linus¹ when he told 
me to make it a generic thing rather than calling it pcmcia_queue_task()


¹ "Blasphemy! He said it again!"

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
