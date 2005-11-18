Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161081AbVKRLwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161081AbVKRLwY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 06:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161080AbVKRLwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 06:52:24 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:62408 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1161081AbVKRLwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 06:52:24 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Subject: Re: Compaq Presario "reboot" problems
Date: Fri, 18 Nov 2005 13:51:41 +0200
User-Agent: KMail/1.8.2
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0511171314440.10063@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0511171314440.10063@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511181351.41159.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 November 2005 20:51, linux-os (Dick Johnson) wrote:
> 
> With Linux-2.4.26 I reported that if a Compaq gets rebooted while
> running Linux-2.4.26, it will not be able to restart Windows 2000.
> It cam restart Linux fine. Today, I tried the same thing with
> Linux-2.6.13.4. It fails, too.
> 
> The symptoms are that you just "reboot" Linux. When the GRUB loader
> comes up, I select my Windows-2000/professional. That M$ Crap comes
> up to where it's just about to start the high-resolution screen.
> Then it stops forever, no interrupts, no nothing. I need to disconnect
> power and remove the battery to recover.
> 
> It appears as though Linux is still restarting as a "warm boot",
> rather than a cold boot (in other words, putting magic in the
> shutdown byte of CMOS) so the hardware doesn't get properly
> initialized. Would somebody please check this out. When changing
> operating systems, you need a cold-boot.

Can you check which driver does that? The test would be to
boot a special Linux setup which reboots immediately
(say, wuth init=/some/reboot_script.sh boot param).

Then start removing drivers from kernel until you
can boot Win successfully after Linux reboots.
--
vda
