Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbULTAoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbULTAoK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 19:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbULTAoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 19:44:09 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:46013 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261362AbULTAoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 19:44:05 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.10-rc3-mm1: swsusp
Date: Mon, 20 Dec 2004 01:44:00 +0100
User-Agent: KMail/1.7.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200412181852.31942.rjw@sisk.pl> <20041219173433.GA1130@elf.ucw.cz>
In-Reply-To: <20041219173433.GA1130@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412200144.00945.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 of December 2004 18:34, Pavel Machek wrote:
> Hi!
> 
[-- snip --]
> 
> > Still, unfortunately, today it crashed on suspend and I wasn't able to get
> > any useful information related to the crash, because swsusp apparently
> > does not send some of its messages to the serial console.  In particular,
> > anything from within the critical section is not printed there and that's
> > why I think (I'm not sure though) that the crash occured in the critical
> > section.  Could you tell me please if it's possible to make all of the
> > swsusp messages appear on the serial console and, if so, how to do this
> > (I've already tried "dmesg -n 8" and "echo 9 > /proc/sysrq-trigger" but
> > none of them helps)? 
> 
> Using regular vga console and digital camera seems to be popular way
> to get dumps.

Well, the problem is that:
1) I don't have a DC,
2) even if I had one, my VTs go nuts after switching to X and then they only 
display garbage ... :-)

> I'm not sure why swsusp critical section interferes with 
> serial, perhaps serial console support has to "know" about serial
> console and not suspend it during suspend() call?

It didn't do that before 2.6.9 or so.  Something must have changed afterwards.  
And the serial console shows messages that appear right before writing the 
image to swap (like "swsusp: Version: ..." etc.).

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
