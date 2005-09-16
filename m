Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161208AbVIPRm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161208AbVIPRm7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 13:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161210AbVIPRm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 13:42:59 -0400
Received: from mail-red.bigfish.com ([216.148.222.61]:45770 "EHLO
	mail28-red-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1161208AbVIPRm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 13:42:58 -0400
X-BigFish: V
Message-ID: <432B0421.3060807@am.sony.com>
Date: Fri, 16 Sep 2005 10:42:57 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: jesper.juhl@gmail.com, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: early printk timings way off
References: <9a87484905091515495f435db7@mail.gmail.com> <432AFB01.3050809@am.sony.com> <Pine.LNX.4.61.0509161909500.31820@gans.physik3.uni-rostock.de> <Pine.LNX.4.61.0509161920370.31820@gans.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.61.0509161920370.31820@gans.physik3.uni-rostock.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau wrote:
> On Fri, 16 Sep 2005, Tim Schmielau wrote:
> The "Detected 1400.279 MHz processor." line just happens to be written
> _during_ time_init, when use_tsc is already set, but cycles_2_ns is not
> yet initialized.

That's exactly what I surmised as well.  Our e-mails must
have crossed each other.  :-)

> So I think everything is well-understood. It's just a matter of whether 
> it's worth fixing.

Exactly.  My own testing has focused on bootup time measurement.
Historically, the time spent before time_init() has been relatively
small and so I haven't (often) focused on trying to measure it
accurately.  Although, I have done this on occasion to get
complete results.

Andrew's suggestion of a replaceable clock function would
satisfy me.  What do other's think?

 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

