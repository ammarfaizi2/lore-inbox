Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbVBKDZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVBKDZa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 22:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVBKDZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 22:25:30 -0500
Received: from smtp-out-01.utu.fi ([130.232.202.171]:47518 "EHLO
	smtp-out-01.utu.fi") by vger.kernel.org with ESMTP id S262114AbVBKDZZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 22:25:25 -0500
Date: Fri, 11 Feb 2005 05:25:19 +0200
From: Jan Knutar <jk-lkml@sci.fi>
Subject: Re: Reading Bad DVD Under 2.6.10 freezes the box.
In-reply-to: <Pine.LNX.4.61.0502070939320.21570@chaos.analogic.com>
To: linux-os@analogic.com
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       Xavier Bestel <xavier.bestel@free.fr>
Message-id: <200502110525.19433.jk-lkml@sci.fi>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
References: <Pine.LNX.4.62.0502070728520.1743@p500>
 <1107783980.6191.154.camel@gonzales>
 <Pine.LNX.4.61.0502070939320.21570@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 February 2005 16:46, linux-os wrote:

> Basically, when you start getting the kernel error messages on
> linux-2.4.22, you can ^C out and everything will quiet down.

Not in my experience.

> With Linux-2.6.10, nothing entered from the keyboard will
> do anything. Since the Caps-Lock key still functions, interrupts
> are still active. However, it is likely the kernel-lock that
> prevents signals (like ^C or ^/) from being executed.

Speculations aside, I have found only one sure way of breaking
the eternal kernel-hang if you make the mistake of inserting a bad
CD into your drive; Needlehole eject.

Sure, the kernel will spit loads of error messages at you, but atleast
it wont be hung anymore, you can save work and reboot.

For eternal hangs when burning CDs though, I've found the only
reliable way of unhanging the system is to unplug power to the 
CD burner and replug it. This seems to cause some amount of
disk corruption to the master device on the same IDE channel
though, so I guess if you have two harddrives, like me, it is a
hard choice between risking corruption on both, and risking
corruption on one.

HTH
