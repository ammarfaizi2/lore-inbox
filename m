Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130150AbQKTL7E>; Mon, 20 Nov 2000 06:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129308AbQKTL6y>; Mon, 20 Nov 2000 06:58:54 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:6922
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129210AbQKTL6m>; Mon, 20 Nov 2000 06:58:42 -0500
Date: Mon, 20 Nov 2000 03:28:28 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Andries Brouwer <aeb@veritas.com>
cc: Taisuke Yamada <tai@imasy.or.jp>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Large "clipped" IDE disk support for 2.4 when using old
 BIOS
In-Reply-To: <20001120032615.A1540@veritas.com>
Message-ID: <Pine.LNX.4.10.10011200326060.22419-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andries,

Don't you mean

(drive->id->cfs_enable_1 & 0x0400)		word85
and not
(drive->id->command_set_1 & 0x0400)		word82

Because when bit 10 of word 85 is not set then clip or HPArea is not enabled.

Cheers,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
