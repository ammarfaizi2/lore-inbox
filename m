Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263789AbUESDxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263789AbUESDxk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 23:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbUESDxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 23:53:40 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5580 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263786AbUESDwF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 23:52:05 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Brad Campbell <brad@wasp.net.au>
Subject: Re: libata 2.6.5->2.6.6 regression -part II
Date: Tue, 18 May 2004 15:13:12 +0200
User-Agent: KMail/1.5.3
References: <40A8E9A8.3080100@wasp.net.au>
In-Reply-To: <40A8E9A8.3080100@wasp.net.au>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405181513.12920.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 of May 2004 18:34, Brad Campbell wrote:
> G'day all,
> I caught the suggestion on my last post in the archives, but because I'm
> not subscribed and wasn't cc'd I can't keep it threaded.
>
> I tried backing out the suggested acpi patch (No difference at all), and I
> managed to get apic to work but it still hangs solid in the same place.
>
> dmesg attached.
>
> I managed to figure out that the VIA ATA driver captures my sata drives on
> the via ports, explaining why sata_via misses them, but writing data to
> those drives (hde & hdg) causes dma timeouts and locks the machine. No
> useful debug info produced. The machine becomes non-responsive, throws a
> couple of dma timeouts to the console and then loses all interactivity
> (keyboard, serial, network) forcing a reset push.
>
> Is there any way I can prevent the VIA ATA driver capturing this device?
> Unfortunately my boot drive is on hda on the on-board VIA ATA interface so
> I need it compiled in.

Disable the fscking PCI IDE generic driver.
[ You are not the first one tricked by it. ]

AFAIR support for VIA 8237 was added to it before sata_via.c was ready.
[ but my memory is... ]

> Please CC: me on any replies.
>
> Regards,
> Brad

