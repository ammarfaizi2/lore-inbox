Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131455AbQLFUiP>; Wed, 6 Dec 2000 15:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131462AbQLFUiF>; Wed, 6 Dec 2000 15:38:05 -0500
Received: from lynx.Lynx.COM ([207.21.185.2]:50441 "EHLO lynx.Lynx.COM")
	by vger.kernel.org with ESMTP id <S131455AbQLFUhv>;
	Wed, 6 Dec 2000 15:37:51 -0500
Message-ID: <3A2E3A90.A8B570A2@LynuxWorks.com>
Date: Wed, 06 Dec 2000 05:09:36 -0800
From: Vitaly Luban <vluban@LynuxWorks.COM>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steve Hill <steve@navaho.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Serial Console
In-Reply-To: <Pine.LNX.4.21.0012051202120.1578-100000@sorbus.navaho>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Steve Hill wrote:

> I'm building boxes with the console set to /dev/ttyS0.  However, I can't
> guarantee that there will always be a term plugged into the serial
> port.  If there is no term on the port, eventually the buffer fills and
> any processes that write to the console (i.e. init) block.  Is there some
> option somewhere to stop this happening (i.e. either ignoring the
> flow-control or just allowing the buffer to overflow)?
>

Try the following into /etc/inittab

s1:12345:respawn:/sbin/agetty -L 19200 ttyS0 vt100

"-L" here means "ignore flow control", the rest, as you wish.

Hope this helps,

Vitaly.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
