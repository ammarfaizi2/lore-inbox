Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269926AbRIAAUg>; Fri, 31 Aug 2001 20:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269962AbRIAAU1>; Fri, 31 Aug 2001 20:20:27 -0400
Received: from sweetums.bluetronic.net ([66.57.88.6]:1674 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S269926AbRIAAUP>; Fri, 31 Aug 2001 20:20:15 -0400
Date: Fri, 31 Aug 2001 20:20:33 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: IPX and PCMCIA
Message-ID: <Pine.GSO.4.33.0108312012050.23852-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(don't ask why I activated IPX on my laptop)

Kernel: 2.4.9 [Linus variety]
Network Adapter: Intel EtherExpress 100 + 56k modem

Here's an interesting bug(let)... load any old PCMCIA network adapater and
then activate IPX.  Then, rmmod the module without taking any steps to
shutdown IPX.  You end up with the interface (eth0) actually gone with IPX
still hanging on to it -- that makes it very hard to delete IPX.  The module
is still loaded, however in the "deleted" state.  And unregister_netdev()
keeps spewing busy alerts to every tty.

In my case, I have to shutdown the PCMCIA adapter before I suppend or the
card will never come back up without physically removing it from the laptop.

--Ricky


