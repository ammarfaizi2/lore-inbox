Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLEPiI>; Tue, 5 Dec 2000 10:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130570AbQLEPh6>; Tue, 5 Dec 2000 10:37:58 -0500
Received: from main.cornernet.com ([209.98.65.1]:37390 "EHLO
	main.cornernet.com") by vger.kernel.org with ESMTP
	id <S129340AbQLEPhv>; Tue, 5 Dec 2000 10:37:51 -0500
Date: Tue, 5 Dec 2000 09:07:57 -0600 (CST)
From: Chad Schwartz <cwslist@main.cornernet.com>
To: Steve Hill <steve@navaho.co.uk>
cc: PaulJakma <paulj@itg.ie>, <linux-kernel@vger.kernel.org>
Subject: Re: Serial Console
In-Reply-To: <Pine.LNX.4.21.0012051456070.2836-100000@sorbus.navaho>
Message-ID: <Pine.LNX.4.30.0012050906250.10237-100000@main.cornernet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nope, /dev/console *does* block.  ATM I've found a quick workaround - I
> use "stty -F /dev/console clocal -crtscts" to turn off the serial flow
> control at the stawrt of /etc/rc.d/rc.sysinit - this seems to work quite
> well... of course it doesn't stop some program turning flow control back
> on and ballsing it all up again :)

...and to fix that, you could easily travel into
/usr/src/linux/drivers/char/serial.c, and a quick conditionional to check
whether or not the change was being made to a console port - and if it is,
dont allow CRTSCTS to be set.

Chad




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
