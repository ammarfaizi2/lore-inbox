Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLEPdG>; Tue, 5 Dec 2000 10:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129340AbQLEPc5>; Tue, 5 Dec 2000 10:32:57 -0500
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:4623 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id <S129228AbQLEPcw>; Tue, 5 Dec 2000 10:32:52 -0500
Date: Tue, 5 Dec 2000 14:58:15 +0000 (GMT)
From: Steve Hill <steve@navaho.co.uk>
To: PaulJakma <paulj@itg.ie>
cc: linux-kernel@vger.kernel.org
Subject: Re: Serial Console
In-Reply-To: <Pine.LNX.4.30.0012051439070.31704-100000@rossi.itg.ie>
Message-ID: <Pine.LNX.4.21.0012051456070.2836-100000@sorbus.navaho>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2000, PaulJakma wrote:

> how? symlink to /dev/ttyS0, or with console=ttyS0 boot option?

console=ttyS0

> use /dev/console (char, 5,1) for all your programmes and boot the
> kernel with serial console support and .
> 
> /dev/console will go to serial, but afaik it doesn't block for lack of
> a terminal. (has something to do with /dev/console being semantically
> different to /dev/tty..., eg it doesn't block, not sure of the exact
> details).

Nope, /dev/console *does* block.  ATM I've found a quick workaround - I
use "stty -F /dev/console clocal -crtscts" to turn off the serial flow
control at the stawrt of /etc/rc.d/rc.sysinit - this seems to work quite
well... of course it doesn't stop some program turning flow control back
on and ballsing it all up again :)

-- 

- Steve Hill
System Administrator         Email: steve@navaho.co.uk
Navaho Technologies Ltd.       Tel: +44-870-7034015


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
