Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131066AbQKUTYw>; Tue, 21 Nov 2000 14:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129682AbQKUTYo>; Tue, 21 Nov 2000 14:24:44 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:3596 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S131060AbQKUTYa>;
	Tue, 21 Nov 2000 14:24:30 -0500
Message-ID: <3A1AC4E1.80E5F423@mandrakesoft.com>
Date: Tue, 21 Nov 2000 13:54:25 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0test11-ac1
In-Reply-To: <E13yDpy-0004ir-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Change Log
> 
> o       Cleanup console_verbose() dunplication

include/linux/kernel.h:  if we are adding new inlines to kernel headers,
they should be 'static inline'..


> o       3c503 error return cleanup
> o       8390 seperate tx timeout path
> o       Acenic update
> o       Network driver check/request region fixes
> o       Epic100 update

dhinds seemed to question the epic100 fix which is enclosed in
CONFIG_CARDBUS...  also I have a big endian fix for epic100 in my local
tree.

The change to hp-plus is totally unnecessary and backwards... 
[un]load_8390_module is null, has been for a while.  A bombing run was
made recently through most drivers to -remove- the now-null calls to
*_8390_module.


> o       Tulip crash fix on weird eeproms

Hopefully an update with this and more will be out this week.

	Jeff




-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
