Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273333AbRI3MQ3>; Sun, 30 Sep 2001 08:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273345AbRI3MQU>; Sun, 30 Sep 2001 08:16:20 -0400
Received: from colorfullife.com ([216.156.138.34]:19979 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S273333AbRI3MQL>;
	Sun, 30 Sep 2001 08:16:11 -0400
Message-ID: <3BB70D24.8C4367DC@colorfullife.com>
Date: Sun, 30 Sep 2001 14:16:36 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Oliver Seemann <oseemann@cs.tu-berlin.de>, linux-kernel@vger.kernel.org
Subject: Re: rtl8139 nic dies with load (2.4.10, kt266)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> no matter if ftp or smb, when transferring files over eth0 to a win2k
> pc (3com nic), after some seconds or mbytes transfer, suddenly all
> network activity on eth0 dies. the adsl connection over eth1 remains
> alive.

Could you enable debugging in the 8139too driver and send us the dmesg
log?

Around line 170 in linux/drivers/net/8139too.c
replace
	#undef RTL8139_DEBUG
with
	#define RTL8139_DEBUG	1

Recompile, reboot, load eth0 until it locks up, and send us the dmesg
output.

--
	Manfred
