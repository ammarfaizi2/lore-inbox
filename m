Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269081AbRHWQ7R>; Thu, 23 Aug 2001 12:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269099AbRHWQ7I>; Thu, 23 Aug 2001 12:59:08 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:48391 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S269081AbRHWQ6z>;
	Thu, 23 Aug 2001 12:58:55 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200108231658.UAA07224@ms2.inr.ac.ru>
Subject: Re: yenta_socket hangs sager laptop in kernel 2.4.6-> PNPBIOS life saver
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 23 Aug 2001 20:58:38 +0400 (MSK DST)
Cc: kraxel@bytesex.org, alan@lxorguk.ukuu.org.uk, Gunther.Mayer@t-online.de,
        alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <E15Zu68-0003nE-00@the-village.bc.nu> from "Alan Cox" at Aug 23, 1 02:00:35 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> We will see what happens. Certainly if someone wants to provide pnpbios code
> patches for -ac that grab and reserve the motherboard resources from the PCI
> code go ahead.

Khm... this does not look simple. Seems, right way involves modification
of each place, where the same ports are used by kernel.
pcmcia-cs had completely private resource manager, so that it just
did not worry about other subsystems and they still were able to allocate
the same resources.

Look f.e. at extermal example, pnpbios announces as "system" resource
all the memory. :-)

Pallaitive soultions, sort of reserving of ports >= 0x1000 using
this information do not look cool too. 

Alexey
