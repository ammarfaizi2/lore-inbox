Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264088AbUFFTqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbUFFTqr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 15:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUFFTqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 15:46:47 -0400
Received: from gprs214-14.eurotel.cz ([160.218.214.14]:34177 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264090AbUFFTqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 15:46:40 -0400
Date: Sun, 6 Jun 2004 21:46:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dominik Brodowski <linux@dominikbrodowski.de>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>, greg kh <greg@kroah.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: Too much error in __const_udelay() ?
Message-ID: <20040606194629.GB10081@elf.ucw.cz>
References: <1086419565.2234.133.camel@cog.beaverton.ibm.com> <20040605152326.GA11239@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040605152326.GA11239@dominikbrodowski.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Change 3:
> 
> Asserting at least 1 loop is spent: in really small ndelay() calls to
> low-mhz timers, this might be better.
> 
>         return __delay(xloops ? xloops : 1);

Should not you always round up? If user asks you to delay 1900 usec,
delaying 1000 usec is a bug. If you do this, make-it-one-when-its-zero
hack should be unneccessary.
								Pavel

-- 
934a471f20d6580d5aad759bf0d97ddc
