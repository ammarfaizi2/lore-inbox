Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLEPPG>; Tue, 5 Dec 2000 10:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129707AbQLEPOv>; Tue, 5 Dec 2000 10:14:51 -0500
Received: from [193.120.224.170] ([193.120.224.170]:49029 "EHLO
	florence.itg.ie") by vger.kernel.org with ESMTP id <S129370AbQLEPOn>;
	Tue, 5 Dec 2000 10:14:43 -0500
Date: Tue, 5 Dec 2000 14:44:13 +0000 (GMT)
From: Paul Jakma <paulj@itg.ie>
To: Steve Hill <steve@navaho.co.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Serial Console
In-Reply-To: <Pine.LNX.4.21.0012051202120.1578-100000@sorbus.navaho>
Message-ID: <Pine.LNX.4.30.0012051439070.31704-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2000, Steve Hill wrote:

>
> I'm building boxes with the console set to /dev/ttyS0.

how? symlink to /dev/ttyS0, or with console=ttyS0 boot option?

> However, I can't
> guarantee that there will always be a term plugged into the serial
> port.  If there is no term on the port, eventually the buffer fills and
> any processes that write to the console (i.e. init) block.  Is there some
> option somewhere to stop this happening (i.e. either ignoring the
> flow-control or just allowing the buffer to overflow)?

IIRC/AFAIK:

use /dev/console (char, 5,1) for all your programmes and boot the
kernel with serial console support and .

/dev/console will go to serial, but afaik it doesn't block for lack of
a terminal. (has something to do with /dev/console being semantically
different to /dev/tty..., eg it doesn't block, not sure of the exact
details).

--paulj

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
