Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261677AbSJFQ37>; Sun, 6 Oct 2002 12:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261682AbSJFQ37>; Sun, 6 Oct 2002 12:29:59 -0400
Received: from pa90.banino.sdi.tpnet.pl ([213.76.211.90]:4357 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S261677AbSJFQ35>; Sun, 6 Oct 2002 12:29:57 -0400
Subject: Re: [patch] fix parport_serial / serial link order (for 2.4.20-pr e8)
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A79D1@EXCHANGE>
To: Ed Vance <EdV@macrolink.com>
Date: Sun, 6 Oct 2002 18:35:10 +0200 (CEST)
CC: "'Russell King'" <rmk@arm.linux.org.uk>,
       Marek Michalkiewicz <marekm@amelek.gda.pl>,
       linux-kernel@vger.kernel.org, Tim Waugh <twaugh@redhat.com>
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E17yEN4-0007fZ-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here are the parport_serial / NM9835 patches, updated for 2.4.20-pre9:

http://www.amelek.gda.pl/linux-patches/2.4.20-pre9/00_parport_serial
http://www.amelek.gda.pl/linux-patches/2.4.20-pre9/01_netmos
http://www.amelek.gda.pl/linux-patches/2.4.20-pre9/02_sagatek

Please apply in this order, 00_parport_serial then 01_netmos.
00_parport_serial is big because it moves parport_serial.c to
a different directory (but no single line in that file is changed).
01_netmos adds NetMos PCI multi I/O support, tested on NM9835 and
working fine in two (soon three) machines here.  So I removed the
"not tested" comments from the NM9835 lines of the original patch.

In addition to the two patches, you get the third one (02_sagatek)
for FREE :) - it is independent of the two, and adds support for
a buggy USB/CompactFlash adapter, known under 3 different names:
Datafab KECF-USB, Sagatek DCS-CF, Simpletech Flashlink UCF-100
(I have the Sagatek DCS-CF, others tested by two other people).

These are the patches I apply to every kernel I build (to support
my hardware), in addition to the usual i2c and lm_sensors patches.

Thanks,
Marek

