Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLKDJK>; Sun, 10 Dec 2000 22:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129450AbQLKDI7>; Sun, 10 Dec 2000 22:08:59 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:31499 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129345AbQLKDIl>;
	Sun, 10 Dec 2000 22:08:41 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200012110236.eBB2ar7216847@saturn.cs.uml.edu>
Subject: Re: hotplug mopup
To: Marcus.Meissner@caldera.de (Marcus Meissner)
Date: Sun, 10 Dec 2000 21:36:53 -0500 (EST)
Cc: andrewm@uow.edu.au (Andrew Morton), linux-kernel@vger.kernel.org
In-Reply-To: <200012101510.QAA29551@ns.caldera.de> from "Marcus Meissner" at Dec 10, 2000 04:10:01 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcus Meissner writes:

>> - On the unregister/removal path, the netdevice layer ensures that
>>   the interface is removed from the kernel namespace prior to launching
>>   `/sbin/hotplug net unregister eth0'.
>>
>>   This means that when handling netdevice unregistration
>>   /sbin/hotplug cannot and must not attempt to do anything with eth0!
>>   Generally it'll fail to find an interface with this name.  If it does
>>   find eth0, it'll be the wrong one due to a race.
>
> I always thought I should have to do "/sbin/ifdown eth0" here.
> (Just as I do /sbin/ifup eth0 on register.)

Yes, definitely. Otherwise, how can one replace the eth0 hardware
without messing up the network settings? This is supposed to be
hot plug and all... to me that means I can rip out one network
card and pop in another without breaking my ssh connections.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
