Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266575AbUGKMJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266575AbUGKMJO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 08:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266577AbUGKMJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 08:09:13 -0400
Received: from astro.futurequest.net ([69.5.28.104]:36055 "HELO
	astro.futurequest.net") by vger.kernel.org with SMTP
	id S266575AbUGKMJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 08:09:11 -0400
From: Daniel Schmitt <pnambic@unu.nu>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.7] Ehci controller interrupts like crazy on nforce2
Date: Sun, 11 Jul 2004 14:09:09 +0200
User-Agent: KMail/1.6.2
References: <40EDF209.70707@yahoo.ca>
In-Reply-To: <40EDF209.70707@yahoo.ca>
Cc: Jonathan Filiatrault <lintuxicated@yahoo.ca>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407111409.09405.pnambic@unu.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 July 2004 03:16, Jonathan Filiatrault wrote:
> Here it is: another nforce2 hardware bug. The ehci controller seems to
> send a massive number of interrupts to the kernel (264379 per second).
> This uses about 5 to 10% of the cpu. This shows up in top in the
> "hi"(hard interrupts) indicator. Nothing unusual shows up in the kernel
> log. My system has an Asus A7N8X Nforce2 Board with an Athlon XP 2800+
> mounted on it.

I've seen this problem on my board (Epox 8RDA3+) as well. The root cause seems 
to be interrupt link devices enabled without regard for the actual device 
status. A recent patch that delayed IRQ assignment to device activiation time 
fixed this for me; you might want to try a fresh -mm or -bk kernel.

Hope that helps,

Daniel.
