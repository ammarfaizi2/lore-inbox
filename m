Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbQLUEoE>; Wed, 20 Dec 2000 23:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130378AbQLUEny>; Wed, 20 Dec 2000 23:43:54 -0500
Received: from Mail.ubishops.ca ([192.197.190.5]:22800 "EHLO Mail.ubishops.ca")
	by vger.kernel.org with ESMTP id <S129838AbQLUEnm>;
	Wed, 20 Dec 2000 23:43:42 -0500
Message-ID: <3A41833A.C4BF6DCF@yahoo.co.uk>
Date: Wed, 20 Dec 2000 23:12:42 -0500
From: Thomas Hood <jdthood@yahoo.co.uk>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug: 2.4.0-test12 w/ PCMCIA on ThinkPad: KERNEL: 
 assertion(dev->ip_ptr==NULL)failed at 
 dev.c(2422):netdev_finish_unregister
In-Reply-To: <393D1B6D.ECCE0721@mail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.0-test12 compiled on an IBM ThinkPad 600 51U (Pentium II)
with PCMCIA support.  Same behavior with Linus PCMCIA and 
Hinds PCMCIA.  I have a Xircom modem/ethernet card which
works correctly using the serial_cs, xirc2ps_cs, ds, i82365 
and pcmcia_core modules; however when I try to "cardctl eject"
or "reboot" I get first,

"KERNEL: assertion(dev->ip_ptr==NULL)failed at
dev.c(2422):netdev_finish_unregister"

(not exact since I had to copy it down on paper ... doesn't
show up in the logs) then a perpetual series of:

"unregister_netdevice: waiting for eth0 to become free. Usage count =
-1"

messages every five seconds or so.  "ps -A" reveals that
modprobe is running; it can't be killed even with "kill -9".
The "ifconfig" command locks up.

Thomas Hood
Please cc: your replies to me at jdthood_AT_mail.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
