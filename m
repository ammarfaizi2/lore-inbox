Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264563AbUD2OO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264563AbUD2OO3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 10:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264601AbUD2OO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 10:14:29 -0400
Received: from mail9.messagelabs.com ([194.205.110.133]:2690 "HELO
	mail9.messagelabs.com") by vger.kernel.org with SMTP
	id S264563AbUD2OO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 10:14:27 -0400
X-VirusChecked: Checked
X-Env-Sender: icampbell@arcom.com
X-Msg-Ref: server-17.tower-9.messagelabs.com!1083248197!7972094
X-StarScan-Version: 5.2.10; banners=arcom.com,-,-
X-Originating-IP: [194.200.159.164]
Subject: Re: [PATCH] 2.6 I2C epson 8564 RTC chip
From: Ian Campbell <icampbell@arcom.com>
To: stefan.eletzhofer@eletztrick.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Russell King - ARM Linux <linux@arm.linux.org.uk>
In-Reply-To: <20040429135829.GB23468@gonzo.local>
References: <20040429120250.GD10867@gonzo.local>
	 <1083242482.26762.30.camel@icampbell-debian>
	 <20040429135408.G16407@flint.arm.linux.org.uk>
	 <20040429135829.GB23468@gonzo.local>
Content-Type: text/plain
Organization: Arcom Control Systems
Message-Id: <1083248064.26762.46.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Apr 2004 15:14:24 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-29 at 14:58, stefan.eletzhofer@eletztrick.de wrote:
> On Thu, Apr 29, 2004 at 01:54:08PM +0100, Russell King wrote:
> > If you look at the last 2.6-rmk patch, you'll notice that it contains
> > an abstracted RTC driver - I got peed off with writing the same code
> > to support the user interfaces to the variety of RTCs over and over
> > again.  (Ones which are simple 32-bit second counters with alarms
> > through to ones which return D/M/Y H:M:S.C format.)
> 
> Oh, I wasn't aware of that. I assume that one is not in linus bk tree already?

I don't think so. I found it in patch-2.6.0-test9-rmk1. In particular
arch/arm/common/rtctime.c and include/asm-arm/rtc.h which implement the
generic RTC bit. drivers/char/sa1100-rtc.c and
linux/arch/arm/mach-integrator/time.c have been ported to use it.

It looks very useful, and it would be pretty easy to make an i2c RTC use
it as well.

Ian.
-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road, 			Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom	Phone:  +44 (0)1223 411 200


_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been virus scanned by MessageLabs.
