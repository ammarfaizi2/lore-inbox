Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262702AbVAQGHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbVAQGHW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 01:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbVAQGHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 01:07:22 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:26031 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S262702AbVAQGHQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 01:07:16 -0500
Message-ID: <41EB5610.1080708@drzeus.cx>
Date: Mon, 17 Jan 2005 07:07:12 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Richard Purdie <rpurdie@rpsys.net>
CC: Russell King <rmk+lkml@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: MMC Driver RFC
References: <021901c4f8eb$1e9cc4d0$0f01a8c0@max> <20050112214345.D17131@flint.arm.linux.org.uk> <023c01c4f8f3$1d497030$0f01a8c0@max> <20050112221753.F17131@flint.arm.linux.org.uk> <41E5B177.4060307@f2s.com> <41E7AF11.6030005@drzeus.cx> <41E7DD5E.5070901@f2s.com> <41EA5C8D.8070407@drzeus.cx> <41EA69F0.5060500@f2s.com> <41EAC3FD.1070001@drzeus.cx> <047701c4fc21$a1579b50$0f01a8c0@max>
In-Reply-To: <047701c4fc21$a1579b50$0f01a8c0@max>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie wrote:

> For reference, I got the 512MB SD card working by adding an mdelay(3) 
> into the middle of mmc_send_op_cond(). Anything shorter and it marks 
> the card as bad...

I fail to see what this delay does. A few lines further down you have a 
mmc_delay which you have removed. That delay was added just to give slow 
cards enough time to power up.

>> That page also contains the legal issues as I've understood them.
>
> *snip*
> So in short, I can't see any reason we can't put the code we have into 
> the kernel...

The point here was that it will probably come back to bite us in the ass 
if we create big obstacles for these companies. Even if it's "their own 
fault" they joined the SD card association. But as Alan pointed out the 
specs. are more or less public by now. Trade secret is most likely out 
of the question, but its difficult to know exactly what the contracts 
they have with their members say.
I, personally, would really like to see SD support included in the main 
kernel. But I can also fully understand if that's not currently possible.

Rgds
Pierre

