Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLAHaG>; Fri, 1 Dec 2000 02:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129426AbQLAH35>; Fri, 1 Dec 2000 02:29:57 -0500
Received: from rmx325-mta.mail.com ([165.251.48.53]:15020 "EHLO
	rmx325-mta.mail.com") by vger.kernel.org with ESMTP
	id <S129257AbQLAH3r>; Fri, 1 Dec 2000 02:29:47 -0500
Message-ID: <391350194.975653957785.JavaMail.root@web425-wra>
Date: Fri, 1 Dec 2000 01:59:15 -0500 (EST)
From: Frank Davis <fdavis112@juno.com>
To: linux-kernel@vger.kernel.org
Subject: Re: test12-pre3 (FireWire issue)
CC: Dax Kelson <dax@gurulabs.com>, fdavis112@juno.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: mail.com
X-Originating-IP: 151.201.246.94
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dax,
   What is your modutils version? Is this the first test12 that has caused this error?
Regards,
Frank

> Linus, Andreas,
> 
> I've been using this same config since FireWire was merged, just tried out
> test12-pre3 and got an unresolved symbol problem with raw1394.o
> 
> #
> # IEEE 1394 (FireWire) support
> #
> CONFIG_IEEE1394=y
> # CONFIG_IEEE1394_PCILYNX is not set
> CONFIG_IEEE1394_OHCI1394=y
> CONFIG_IEEE1394_VIDEO1394=m
> CONFIG_IEEE1394_RAWIO=m
> # CONFIG_IEEE1394_VERBOSEDEBUG is not set
> 
> 
> make bzImage; make modules; make modules_install
> 
> modules_install bombs out with:
> 
> cd /lib/modules/2.4.0-test12; \
> mkdir -p pcmcia; \
> find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
> pcmcia if [ -r System.map ]; then /sbin/depmod -ae -F System.map
> 2.4.0-test12; fi depmod: *** Unresolved symbols in
> /lib/modules/2.4.0-test12/kernel/drivers/ieee1394/raw1394.o
> depmod: 	free_tlabel
> depmod: 	fill_iso_packet
> depmod: 	hpsb_register_highlevel
> depmod: 	highlevel_lock
> depmod: 	hpsb_unregister_highlevel


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
