Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130761AbQKAPnc>; Wed, 1 Nov 2000 10:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131129AbQKAPnW>; Wed, 1 Nov 2000 10:43:22 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:33545
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130761AbQKAPnJ>; Wed, 1 Nov 2000 10:43:09 -0500
Date: Wed, 1 Nov 2000 07:42:45 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: raptor <raptor@antifork.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: possible bug in hd geometry detect code?
In-Reply-To: <Pine.LNX.4.20.0011011436350.516-100000@hacaro.rewt.mil>
Message-ID: <Pine.LNX.4.10.10011010741020.31230-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000, raptor wrote:

> hda: FUJITSU MPF3102AH, ATA DISK drive
> hdc: FUJITSU MPF3102AH, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: FUJITSU MPF3102AH, 9773MB w/2048kB Cache, CHS=1245/255/63, UDMA
> hdc: FUJITSU MPF3102AH, 9773MB w/2048kB Cache, CHS=19857/16/63, UDMA

No your BIOS is stupid and does not assume you will have a disk on the
second channel.  Thus, one does LBA translation and the other does CHS.

Cheers,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
