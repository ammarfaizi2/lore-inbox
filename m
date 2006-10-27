Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752180AbWJ0NTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbWJ0NTd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 09:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752181AbWJ0NTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 09:19:33 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:13346 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1752180AbWJ0NTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 09:19:32 -0400
Message-ID: <454206EE.9080206@sw.ru>
Date: Fri, 27 Oct 2006 17:17:34 +0400
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-ide@vger.kernel.org
CC: devel@openvz.org
Subject: Re: [Q] ide cdrom in native mode leads to irq storm?
References: <453DC2A9.8000507@sw.ru> <453DC65C.8000408@sw.ru>
In-Reply-To: <453DC65C.8000408@sw.ru>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin wrote:
> Vasily Averin wrote:
>> there is node with Intel 7520-based motherboard (MSI-9136), IDE cdrom (hda) and
>> SATA disc and 2.6.19-rc3 linux kernel.
>>
>> When I set IDE controller into the native mode, I get irq storm on the node and
>> this interrupt is disabled. If this interrupt is shared, the other subsystems
>> are stop working too.
>>
>> When I switch the IDE controller into legacy mode, all works correctly.

I have reproduced the same issue on the another node:

ASUSTeK P5GD1-VM,
Intel 915G chipset,
ICH6 IDE controller,
IDE dvdrom: SONY DVD-ROM DDU1615 (hda),
sata disk: WDC WD1600JS-00M

when I switch IDE controller to the native mode, I see "Disabling IRQ" message,
then kernel generates an oops in create_empty_buffers(), like I've reported earlier.

Could somebody please help me to troubleshoot this issue? I've seen this issue
on the customer nodes and would like to know how I can work-around this issue
without any changes inside motherboard BIOS.

thank you,
	Vasily Averin
