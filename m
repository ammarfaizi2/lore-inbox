Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269105AbUHaWBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269105AbUHaWBN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 18:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269102AbUHaUFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:05:42 -0400
Received: from smtp9.poczta.onet.pl ([213.180.130.49]:55231 "EHLO
	smtp9.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S268965AbUHaUCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:02:46 -0400
Message-ID: <4134D957.1070101@poczta.onet.pl>
Date: Tue, 31 Aug 2004 22:02:31 +0200
From: =?ISO-8859-2?Q?Maciej_G=F3rnicki?= <gutko@poczta.onet.pl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; pl-PL; rv:1.7.2) Gecko/20040803
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [2.6.9-rc1-bk7]  LIBATA - "irq 11: nobody cared" on sil 3112a 
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Im trying to run libata driver on my Asus A7N8X-deluxe (latest bios 
1008) with Sil 3112a controller,
but i'm permanently getting "irq 11: nobody cared.....disabling irq11" 
error. After this error computer hangs totally.
I found some info about enabling "Enhanced mode" and "Sata only" options 
in bios,
but they are not avalible in my motherboard.
I've managed to chatch some, hopefully, useful info through netconsole.
My kernel config and lspci output are also there. This log was made with 
ACPI compiled in,
but there was exactly same problem when ACPI was not compiled in.
http://www.gutko.neostrada.pl/nobody_cared.txt
Maciej Gornicki
ps. these 2 errors with "eth0: BUG!" appeared when I enabled netconsole.

irq 11: nobody cared!
 [<c01080ca>] __report_bad_irq+0x2a/0x90
 [<c01081bc>] note_interrupt+0x6c/0xa0
 [<c0108491>] do_IRQ+0x121/0x130
 [<c0106674>] common_interrupt+0x18/0x20
 [<c011e530>] __do_softirq+0x30/0x90
 [<c011e5b6>]<4>eth0: BUG! Tx Ring full, refusing to send buffer.
 do_softirq+0x26/0x30
 [<c010846d>] do_IRQ+0xfd/0x130
 [<c0106674>] common_interrupt+0x18/0x20
 [<c0103b93>] default_idle+0x23/0x30
 [<c0103bfc>] cpu_idle+0x2c/0x40
 [<c03827ad>]<4>eth0: BUG! Tx Ring full, refusing to send buffer.
 start_kernel+0x17d/0x1c0
 [<c03823b0>] unknown_bootoption+0x0/0x160
handlers:
[<c02240f0>] (ata_interrupt+0x0/0x1c0)
Disabling IRQ #11




