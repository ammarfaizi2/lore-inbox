Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLEQI0>; Tue, 5 Dec 2000 11:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQLEQIP>; Tue, 5 Dec 2000 11:08:15 -0500
Received: from main.cornernet.com ([209.98.65.1]:12559 "EHLO
	main.cornernet.com") by vger.kernel.org with ESMTP
	id <S129183AbQLEQIG>; Tue, 5 Dec 2000 11:08:06 -0500
Date: Tue, 5 Dec 2000 09:38:16 -0600 (CST)
From: Chad Schwartz <cwslist@main.cornernet.com>
To: Steve Hill <steve@navaho.co.uk>
cc: PaulJakma <paulj@itg.ie>, <linux-kernel@vger.kernel.org>
Subject: Re: Serial Console
In-Reply-To: <Pine.LNX.4.21.0012051528070.2875-100000@sorbus.navaho>
Message-ID: <Pine.LNX.4.30.0012050936500.11114-100000@main.cornernet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unless of course you really DO have RTS/CTS (Or DTR-->CTS) flow control
turned on - on your terminal, and the terminal shuts off RTS (or DTR) to
indicate its fifo level is too high.

That *IS* useful.

but the ability to hard-code it in a shut-off state is *MUCH* better.

Chad

> On Tue, 5 Dec 2000, PaulJakma wrote:
>
> > > ATM I've found a quick workaround - I
> > > use "stty -F /dev/console clocal -crtscts" to turn off the serial flow
> > > control at the stawrt of /etc/rc.d/rc.sysinit - this seems to work quite
> > > well... of course it doesn't stop some program turning flow control back
> > > on and ballsing it all up again :)
> >
> > yukkk...
> >
> > /dev/console having non-blocking semantics sounds much cleaner.
>
> Yep - having a blocking console just seems like plain stupidity :(
>
> --
>
> - Steve Hill
> System Administrator         Email: steve@navaho.co.uk
> Navaho Technologies Ltd.       Tel: +44-870-7034015
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
