Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264930AbUAaQ5d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 11:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbUAaQ5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 11:57:33 -0500
Received: from village.ehouse.ru ([193.111.92.18]:12808 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S264930AbUAaQ5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 11:57:31 -0500
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.1 IO lockup on SMP systems
Date: Sat, 31 Jan 2004 19:40:27 +0300
User-Agent: KMail/1.5.4
Cc: anton@megashop.ru
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401311940.28078.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I had experienced a lockups on three of my servers with 2.6.1. It doesn't
look like a deadlock, the box is still pingable and all tcp ports which were
 in listen state before a lockup are remains in listen state, but I can't get
any data from this ports. According to sar(1) systems had not been overloaded
right before a lockup. And there is no log entries in all user services logs
for almost 10 hours after lockup.

So I think this is an IO lockup. On the other side it doesn't look like a bug
 in particular controller driver, because they are different for each box.
And finally it doesn't look like a bug in particular io-scheduler because two
of boxes were runed with "deadline" and one with "as". Of course all
assumptions are valid only if all lockups I had seen have the same nature.

All of three boxes are SMP. Unfortunately all are remote and aren't attached
to a serial console yet (this is planed in next couple of weeks).

1) ope
01:02.1 RAID bus controller: Mylex Corporation: Unknown device 0050 (rev 02)
elevator=deadline
.config:	http://sysadminday.org.ru/2.6.1-io_lockup/ope/.config
lspci:		http://sysadminday.org.ru/2.6.1-io_lockup/ope/lspci
lspci -vvn:	http://sysadminday.org.ru/2.6.1-io_lockup/ope/lspci_-vvn

2) white
02:04.0 RAID bus controller: American Megatrends Inc. MegaRAID (rev 02)
elevator=deadline
.config:	http://sysadminday.org.ru/2.6.1-io_lockup/white/.config
lspci:		http://sysadminday.org.ru/2.6.1-io_lockup/white/lspci
lspci -vvn:	http://sysadminday.org.ru/2.6.1-io_lockup/white/lspci_-vvn

3) tiny
02:00.0 Unknown mass storage controller: Compaq Computer Corporation Smart-2/P RAID Controller (rev 03)
03:00.0 Unknown mass storage controller: Compaq Computer Corporation Smart-2/P RAID Controller (rev 03)
elevator=as
.config:	http://sysadminday.org.ru/2.6.1-io_lockup/tiny/.config
lspci:		http://sysadminday.org.ru/2.6.1-io_lockup/tiny/lspci
lspci -vvn:	http://sysadminday.org.ru/2.6.1-io_lockup/tiny/lspci_-vvn

Any hints will be appreciated.

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc

