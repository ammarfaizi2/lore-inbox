Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265314AbUETXyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265314AbUETXyQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 19:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265315AbUETXyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 19:54:16 -0400
Received: from rs1.physik.Uni-Dortmund.DE ([129.217.168.30]:12434 "EHLO
	rs1.physik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265314AbUETXyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 19:54:14 -0400
Date: Fri, 21 May 2004 01:53:14 +0200
From: Robert Fendt <fendt@physik.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: peculiar problem with 2.6, 8139too + ACPI
Message-Id: <20040521015314.7001a9e9.fendt@physik.uni-dortmund.de>
In-Reply-To: <1084818282.12349.334.camel@dhcppc4>
References: <A6974D8E5F98D511BB910002A50A6647615FB5FE@hdsmsx403.hd.intel.com>
	<1084584998.12352.306.camel@dhcppc4>
	<20040517123011.7e12d297.fendt@physik.uni-dortmund.de>
	<1084818282.12349.334.camel@dhcppc4>
Organization: Lehrstuhl =?ISO-8859-1?B?Zvxy?= experimentelle Physik I,
 =?ISO-8859-1?B?VW5pdmVyc2l05HQ=?= Dortmund
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 May 2004 14:24:42 -0400
Len Brown <len.brown@intel.com> wrote:

> > One additional problem in debugging this is that it seems to be
> > depending on the local network topology, since I somehow cannot
> > reproduce it when downloading from machines on the LAN or when I have a
> > slow downstream connection (e.g. DSL).

Maybe I can add at least some details on the differing network
topologies. My local network is a small 100BaseT network, one single
8-port switch. Connection to "the outside" is made through a
masquerading router (an old 233-PentiumMMX box), which has an ADSL modem
connection (128/768kbit up/down). As I said, I cannot produce the
problem here, neither local nor when fetching data from external
sources.

The second topology is a large corporate-style network (university), so
it consists of several hundred machines and some dozens switches and
routers, at least. The particular section I am connected to is 100BaseFX
based, with BaseT-to-fiber transceiver switches in every office. So the
office is 100BaseT, and the connection between the offices is 100BaseFX.
The whole is connected to the rest of the network through a switch
somewhere in the building, a Cisco thingy I would guess (though I have
never seen it). The connection of the university to the Internet is
something in the gigabit/s range, through the "DFN" (deutsches
Forschungsnetzwerk, German scientific network). I do not have more
information, sorry.

> Does
> cat /proc/acpi/processor/CPU0/power
> show any C3 usage?

Yes, if I read this correctly, it does. BTW, seemingly pretty much the same on AC or battery.

betazed:~# cat /proc/acpi/processor/CPU1/power
active state:            C2
default state:           C1
bus master activity:     ffffffff
states:
    C1:                  promotion[C2] demotion[--] latency[000] usage[00000010]
   *C2:                  promotion[C3] demotion[C1] latency[001] usage[00025200]
    C3:                  promotion[--] demotion[C2] latency[101] usage[00024564]


> I think we're having a similar problem with the ipw2100.  it would
> be interesting if you plugged an e100 into the failing config if
> it fails the same way.

Could be difficult. We do not have such a card in the workgroup (would
have to be PCMCIA, of course; is there even such a thing?), and I would
have to convince my boss of buying one for testing purposes. I _could_
of course try to get the ipw2100 driver working, since we have an ap in
the group (and the laptop is Centrino based, as I mentioned before). I
am not informed on its status, however: does WEP encrytion work now?
Also a test would have to wait until tuesday, anyway, since I will not
return to the office before.

Regards,
Robert
