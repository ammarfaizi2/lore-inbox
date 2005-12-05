Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbVLECDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbVLECDY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 21:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbVLECDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 21:03:24 -0500
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:21889 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751317AbVLECDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 21:03:23 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: fix cpufreq-ondemand by accounting skipped ticks as idle ticks [Was: [PATCH] i386 no idle HZ aka Dynticks 051203]
Date: Mon, 5 Dec 2005 13:02:57 +1100
User-Agent: KMail/1.9
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>, Tony Lindgren <tony@atomide.com>,
       Adam Belay <abelay@novell.com>, Daniel Petrini <d.pensator@gmail.com>,
       vatsa@in.ibm.com
References: <200512041737.07996.kernel@kolivas.org> <20051204122434.GB9503@dominikbrodowski.de>
In-Reply-To: <20051204122434.GB9503@dominikbrodowski.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512051302.58583.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 December 2005 23:24, Dominik Brodowski wrote:
> Account ticks skipped dynamically as idle ticks.
>
> This allows the ondemand cpufreq governor to work correctly with dyntick.

Dominik one thing I noticed a while back was that ondemand also polls at a 
frequency that creates a timer at around 140 HZ. Tweaking the ondemand/ 
tunables and making it poll ten times less frequently made a big difference 
to this (obviously) but did obviously slow down the scaling speed - this was 
the frequency required to bring it to that of the background timers (<=20HZ). 
I see scope for this polling to be dynamic too :D

Cheers,
Con
