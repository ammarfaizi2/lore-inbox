Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263575AbVBDQQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263575AbVBDQQR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 11:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266292AbVBDQQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 11:16:17 -0500
Received: from gprs215-42.eurotel.cz ([160.218.215.42]:28388 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263575AbVBDQQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 11:16:08 -0500
Date: Fri, 4 Feb 2005 17:15:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Cc: Oliver Neukum <oliver@neukum.org>, ncunningham@linuxmail.org,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Reliable video POSTing on resume
Message-ID: <20050204161529.GB1290@elf.ucw.cz>
References: <20050122134205.GA9354@wsc-gmbh.de> <4202DF7B.2000506@gmx.net> <20050204074802.GD1086@elf.ucw.cz> <200502041126.14386.oliver@neukum.org> <42035D5A.2030703@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42035D5A.2030703@gmx.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>What about simply blocking all video accesses before disk (etc) is
> >>resumed, so that "normal" (not locked in memory) application can be
> >>used?
> > 
> > Very bad for debugging. Genuine serial ports are becoming rarer.
> 
> As a bonus, even genuine serial ports may be in undefined state after
> resume. I'm unfortunate enough to have a brand new notebook with
> serial port, but the serial console code will print garbage after
> resume until I do a
> echo foo >/dev/ttyS0

It seems that open helps here. Can you confirm with >/dev/ttyS0
(i.e. without echo foo?). If it helps, all you need to do is simulate
open/close from _resume() routine....
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
