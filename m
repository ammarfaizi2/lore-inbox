Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTLSUcd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 15:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbTLSUcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 15:32:33 -0500
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:61769 "EHLO
	floyd.gotontheinter.net") by vger.kernel.org with ESMTP
	id S263632AbTLSUcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 15:32:32 -0500
Subject: Re: [2.4] Nforce2 oops and occasional hang (tried the lockups
	patch, no difference)
From: Disconnect <lkml@sigkill.net>
To: Craig Bradney <cbradney@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1071865339.9969.3.camel@athlonxp.bradney.info>
References: <200312131225.34937.ross@datscreative.com.au>
	 <1071506410.2030.35.camel@slappy>  <1071773523.1282.6.camel@slappy>
	 <1071854664.6110.21.camel@slappy>
	 <1071865339.9969.3.camel@athlonxp.bradney.info>
Content-Type: text/plain
Message-Id: <1071865952.6159.34.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 19 Dec 2003 15:32:32 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-12-19 at 15:22, Craig Bradney wrote:
> Does this not relate directly to the APIC/IOAPIC issues with 2.6 kernel
> and nforce chipset motherboards? 

Not when apic is disabled. (And I'm guessing you mean 2.4, right?
Although IIRC the patches are available for both.)

The patches for enabling/using apic/io-apic on nforce2 work fine, except
instead of oopsing it hardlocks semi-randomly. (It ran fine for a few
days, then hardlocked, and upon reboot it only made it about 10 minutes,
then another 30 minutes, so I went back to an unpatched 2.4.23 with
'noapic'.  Now that the hardware has arrived I can move production
elsewhere and do further testing.)  I was under the impression that
nmi-watchdog was supposed to prevent the hardlocks (well, turn them into
oopses), but no such luck here.

-- 
Disconnect <lkml@sigkill.net>

