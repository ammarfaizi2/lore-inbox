Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317977AbSHTNoV>; Tue, 20 Aug 2002 09:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318045AbSHTNoV>; Tue, 20 Aug 2002 09:44:21 -0400
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:5638 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id <S317977AbSHTNoU>; Tue, 20 Aug 2002 09:44:20 -0400
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200208201344.g7KDiOjs019742@wildsau.idv.uni.linz.at>
Subject: Re: need contact of via-rhine developers
In-Reply-To: <1029847731.8910.114.camel@ransom> from Rob Myers at "Aug 20, 2 08:48:51 am"
To: rob.myers@gtri.gatech.edu (Rob Myers)
Date: Tue, 20 Aug 2002 15:44:24 +0200 (MET DST)
Cc: kernel@wildsau.idv.uni.linz.at, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> this driver seems to work for the vt6103 in patch-2.4.20-pre2-ac3.

okay, it seems that some code that restarts a hung chip has been
added.
 
> with 2.4.18 it would die after about 2mb of data transferred and not
> recover.

aha? I see stalls occuring frequently too, but earlier than 2mb. the
card is then resetted by "NETDEV WATCHDOG", which appears in dmesg,
and you'll also see a "transmit timeout eth0" (or something similar).
so, if the patch is for a chip that does not recover, I guess it
will not address this problem then (because the netdev-watchdog restarts
the chip which *does* recover then).

my concern is that both vt6102 and vt6103 have been assigned the same
pci-device-id by via. I dont think that the via-rhine driver does
differ the two chips and treats the 6103 as a 6102.

also, on ftp.via.com.tw/...NIC/VT6103, there are no chip-specs, as
opposed to the 6102 and 6105-directory. I've just mailed to
robert_kuo@via.com.tw, I hope they will put up the missing specs.

do you know of any other sources of specs beside ftp.via.com.tw?

regards,
h.rosmanith

