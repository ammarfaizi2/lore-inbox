Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129250AbQKHTYW>; Wed, 8 Nov 2000 14:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129224AbQKHTYM>; Wed, 8 Nov 2000 14:24:12 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:64774
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129250AbQKHTX5>; Wed, 8 Nov 2000 14:23:57 -0500
Date: Wed, 8 Nov 2000 11:23:52 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Taisuke Yamada <tai@imasy.or.jp>
cc: linux-kernel@vger.kernel.org
Subject: Re: Patch: Using clipped IDE disk larger than 32GB with old BIOS
In-Reply-To: <200011081416.eA8EGg001886@research.imasy.or.jp>
Message-ID: <Pine.LNX.4.10.10011081115030.5484-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2000, Taisuke Yamada wrote:

> # I might consider adding support for even newer 48-bit LBA
> # extension (which I read in ATA spec). This will push the
> # limit up to 128PB (wow!).

Hi Taisuke,

So you like that TASKFILE. ;-)

The 48-LBA stuff is on hold because it requires more than simple changes
to ide-disk.c.  The rules for the setting of the HOB and the double pump
of the safety check that allows on to read back the contents before the
command register is executed, is still in development.  We have not voted
on the final design of the 48-LBA and no drive or BIOS guys have any
product ready for testing.

Cheers,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
