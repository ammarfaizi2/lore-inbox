Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129667AbQKZULH>; Sun, 26 Nov 2000 15:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129770AbQKZUK6>; Sun, 26 Nov 2000 15:10:58 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:63492 "EHLO
        imladris.demon.co.uk") by vger.kernel.org with ESMTP
        id <S129667AbQKZUKu>; Sun, 26 Nov 2000 15:10:50 -0500
Date: Sun, 26 Nov 2000 19:40:43 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Jeff Epler <jepler@inetnebr.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test11(-ac4)/i386 configure bug
In-Reply-To: <20001126120738.A2684@potty.housenet>
Message-ID: <Pine.LNX.4.30.0011261936370.13161-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2000, Jeff Epler wrote:

> How can you have the console on a modularized device?

You can have more than one console device. Only the primary device needs
to be present at boot time. Actually, I'm not sure even that has to be
present.

Since I added unregister_console() a long time ago, you can dynamically
add and remove console devices.

> Above, this is correctly forbidden for serial console.
>
> Or can I dynamically change the console device after bootup?

Not change. Add a new one. console != preferred_console.

And in this case, it's exactly what you want.  You don't want all the
normal bootup cruft, you want to load the driver after the boot is
finished, and only catch oopsen.


--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
