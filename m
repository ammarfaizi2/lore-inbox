Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130312AbQK0RIP>; Mon, 27 Nov 2000 12:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131637AbQK0RIF>; Mon, 27 Nov 2000 12:08:05 -0500
Received: from netwinder.org ([207.245.35.202]:47350 "EHLO kei.netwinder.org")
        by vger.kernel.org with ESMTP id <S130312AbQK0RHw>;
        Mon, 27 Nov 2000 12:07:52 -0500
Message-ID: <3A228DDE.61BEAFD8@netwinder.org>
Date: Mon, 27 Nov 2000 11:37:50 -0500
From: "Andrew E. Mileski" <andrewm@netwinder.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Universal debug macros.
In-Reply-To: <Pine.LNX.4.10.10011270109020.11180-100000@yle-server.ylenurme.sise>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Elmer Joandi wrote:
> 
> Now if there would be simple _unified_ system for switching debug code
> on/off, it would be a real win. That  recompilation-capable enduser would
> not need much knowledge to go "General Setup" or newly created
> "Optimization" section and switch debugging off/on for _all_ network
> drivers or ide drivers for example.

Reminds me ... <linux/kernel.h> has a "#if DEBUG" statement that blows
up if the debug code does something like "#define DEBUG(X...) printk(X...)".
I came across this recently (think I was debugging PCI code ... not sure).
Changing it to "#ifdef DEBUG" avoids problems.

--
Andrew E. Mileski - Software Engineer
Rebel.com  http://www.rebel.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
