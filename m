Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751563AbWGPJid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbWGPJid (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 05:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWGPJid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 05:38:33 -0400
Received: from mail.gmx.de ([213.165.64.21]:21413 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751531AbWGPJid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 05:38:33 -0400
X-Authenticated: #5082238
Date: Sun, 16 Jul 2006 10:43:46 +0200
From: Carsten Otto <c-otto@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Very poor IO performance (high CPU load), libata
Message-ID: <20060716084346.GA6370@server.c-otto.de>
Reply-To: c-otto@gmx.de
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060715174555.GA27640@server.c-otto.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060715174555.GA27640@server.c-otto.de>
X-GnuGP-Key: http://c-otto.de/pubkey.asc
User-Agent: Mutt/1.5.11+cvs20060403
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem solved!

On Sat, Jul 15, 2006 at 07:45:57PM +0200, Carsten Otto wrote:
> In the problem case the IO wait never drops below 40% no matter how light
> the HDD load is. Logging in into the system via SSH then takes more than
> two minutes and other tasks are equally slow.

Okay, the wait percentage is no problem, but the speed is.
I had to use a second power supply for two of the four SATA disks,
because the main supply is not good enough and causes crashes and
reboots (see my other threads, I will answer there too).
In a test that checked each disk seperately I noticed that exactly those
disks connected to the second power supply perform very poor with write
accesses (65 MB/sec vs. 2 MB/sec). I replaced the second (bad) power
supply with a very good one and now all disks are working fine. My new
main power supply should arrive soon.

I still can't understand why disks work slower when provided with
"wrong" power... The disks are Maxtor MaXLine III 7V300F0.

> There might be a problem with my hardware (in a not yet determined
> device) causing this problem. But as long as I do not know what is wrong
> I still see the chance of a software error in the kernel.

Yeah, the kernel is okay :)

PS: Now a very annoying hunt for some error in my computer ends after
about three weeks. The system now is stable and fast and I am happy...

Bye and sorry for bugging you,
-- 
Carsten Otto
c-otto@gmx.de
www.c-otto.de
