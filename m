Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264618AbUD2O2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264618AbUD2O2i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 10:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264621AbUD2O2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 10:28:38 -0400
Received: from gonzo.one-2-one.net ([217.115.142.69]:38616 "EHLO
	gonzo.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S264618AbUD2O2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 10:28:31 -0400
Envelope-to: linux-kernel@vger.kernel.org
Date: Thu, 29 Apr 2004 16:28:02 +0200
From: stefan.eletzhofer@eletztrick.de
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6 I2C epson 8564 RTC chip
Message-ID: <20040429142802.GA24974@gonzo.local>
Reply-To: stefan.eletzhofer@eletztrick.de
Mail-Followup-To: stefan.eletzhofer@eletztrick.de,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040429120250.GD10867@gonzo.local> <1083242482.26762.30.camel@icampbell-debian> <20040429135408.G16407@flint.arm.linux.org.uk> <20040429135829.GB23468@gonzo.local> <1083248064.26762.46.camel@icampbell-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083248064.26762.46.camel@icampbell-debian>
User-Agent: Mutt/1.3.27i
Organization: Eletztrick Computing
X-HE-MXrcvd: no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 03:14:24PM +0100, Ian Campbell wrote:
> On Thu, 2004-04-29 at 14:58, stefan.eletzhofer@eletztrick.de wrote:
> > On Thu, Apr 29, 2004 at 01:54:08PM +0100, Russell King wrote:
> > > If you look at the last 2.6-rmk patch, you'll notice that it contains
> > > an abstracted RTC driver - I got peed off with writing the same code
> > > to support the user interfaces to the variety of RTCs over and over
> > > again.  (Ones which are simple 32-bit second counters with alarms
> > > through to ones which return D/M/Y H:M:S.C format.)
> > 
> > Oh, I wasn't aware of that. I assume that one is not in linus bk tree already?
> 
> I don't think so. I found it in patch-2.6.0-test9-rmk1. In particular
> arch/arm/common/rtctime.c and include/asm-arm/rtc.h which implement the
> generic RTC bit. drivers/char/sa1100-rtc.c and
> linux/arch/arm/mach-integrator/time.c have been ported to use it.
> 
> It looks very useful, and it would be pretty easy to make an i2c RTC use
> it as well.

Ah, haven't had a look at 2.6.0-test9 for some time now. I'll try to check
these and maybe I'll port my rtc driver over to it. Maybe these files
sould be moved out of the arm tree, though? It may well be that other platforms
are interested it (at last I've found a drivers/char/genrtc.c ...).

> 
> Ian.
> -- 
> Ian Campbell, Senior Design Engineer
>                                         Web: http://www.arcom.com
> Arcom, Clifton Road, 			Direct: +44 (0)1223 403 465
> Cambridge CB1 7EA, United Kingdom	Phone:  +44 (0)1223 411 200
> 
> 
> _____________________________________________________________________
> The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.
> 
> This message has been virus scanned by MessageLabs.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Eletztrick Computing - Customized Linux Development
Stefan Eletzhofer, Marktstrasse 43, DE-88214 Ravensburg
http://www.eletztrick.de
