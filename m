Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265791AbSKKQWU>; Mon, 11 Nov 2002 11:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265803AbSKKQWU>; Mon, 11 Nov 2002 11:22:20 -0500
Received: from gandalf.intelligraphics.com ([216.206.147.132]:4113 "EHLO
	gandalf.intelligraphics.com") by vger.kernel.org with ESMTP
	id <S265791AbSKKQWT>; Mon, 11 Nov 2002 11:22:19 -0500
Message-ID: <3DCFDAD7.9080003@intelligraphics.com>
Date: Mon, 11 Nov 2002 17:29:11 +0100
From: George Andre <george.andre@intelligraphics.com>
Reply-To: george.andre@intelligraphics.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: alan@lxorguk.ukuu.org.uk
Subject: [BUG] PCI-2-Cardbus bridge, Kernel PCMCIA services and Cardbus
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,

I have a strange problem with virtually all 2.4 kernels,
(tried 2.4.18 to 2.4.20-rc1). I'm developing a driver
for a wireless card for our customer. Since it's a Cardbus
wireless card and my dev machine is a desktop, I'm using
a Ricoh 5c475 based PCI-2-Cardbus bridge.

My problem is that the yenta_socket.o driver (or pcmcia_core.o)
indeed create  Cardbus bus with my device on it, but the BAR's
are all messed up. I get negative len ranges on the MMIO addresses
(0xE7010000 - 0xE7003FFF).

I'm not sure this is a problem in the Kernel PCMCIA drivers, because
even with them not loaded, the Ricoh device (Cardbus bridge) contains
weird bridge resources (offset 0x1C and forward in the PCI
config space headertype 0x02). This doesn't happen only with my
customers wireless card, but with one another different vendors wireless
card too.

I've even tried Alan Cox' 2.4.20-pre10-ac2 patch with no success.

Anyone seen this before and know where I might throw my search lights ?

Thanks,
George.

