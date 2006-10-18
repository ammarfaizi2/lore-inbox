Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWJRDnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWJRDnD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 23:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWJRDnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 23:43:02 -0400
Received: from smtpout.mac.com ([17.250.248.177]:38102 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751250AbWJRDnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 23:43:00 -0400
In-Reply-To: <Pine.LNX.4.64.0610172125560.1846@constellation.wizardsworks.org>
References: <Pine.LNX.4.64.0610171743530.952@constellation.wizardsworks.org> <Pine.LNX.4.64.0610172125560.1846@constellation.wizardsworks.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6A14BCE4-1A0B-44AD-B420-2D644FFB0659@mac.com>
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Touchscreen hardware hacking/driver hacking.
Date: Tue, 17 Oct 2006 23:42:34 -0400
To: Greg Chandler <chandleg@constellation.wizardsworks.org>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 17, 2006, at 22:30:57, Greg Chandler wrote:

>
> I added the following to drivers/input/mouse/lifebook.c
>        {
>                .ident = "FLORA-ie 55mi",
>                .matches = {
>                        DMI_MATCH(DMI_PRODUCT_NAME, "FLORA-ie 55mi"),
>                },
>        },
>
> It scrolled oopses for a little while then booted normally.
> gpmd using /dev/mouse is taking input from the touchscreen. kind  
> of....
>
> If I move up or down on the screen it moves the cursor like a mouse  
> would, but it acts like the button is always pressed.
>
> I'm happy that it accepts data at all but concerned about the oops  
> scroll...  There is so much that it is pushed out of the dmesg log,  
> and the kernel scrollback log.  I have no way of recording it {I  
> can't soldier down a pin header for serial}
>
> Any ideas?

Pass "log_buf_len=4M" on the kernel command line (or pick any other  
power of 2).  Without a suffix specifies size in bytes, "k" means 1  
kiB or 2^10 bytes, "M" means 1 MiB or 2^20 bytes.

Cheers,
Kyle Moffett

