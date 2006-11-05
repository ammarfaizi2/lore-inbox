Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbWKEOfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbWKEOfn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 09:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWKEOfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 09:35:43 -0500
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:17104 "EHLO
	rhlx01.hs-esslingen.de") by vger.kernel.org with ESMTP
	id S1030269AbWKEOfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 09:35:42 -0500
Date: Sun, 5 Nov 2006 15:35:40 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Dmitry Bohush <dmitrij.bogush@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: High pitch noise on Acer Aspire 5602WLMi
Message-ID: <20061105143540.GA29570@rhlx01.hs-esslingen.de>
References: <2ac89c700611042257p6c4ea9cdsdfb7b2d3f2415d8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ac89c700611042257p6c4ea9cdsdfb7b2d3f2415d8a@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Nov 05, 2006 at 08:57:09AM +0200, Dmitry Bohush wrote:
> Hello,  Probably it is one of resistors on motherboard. This noise
> goes away with adding acpi=off to boot params.
> 
> What is this? It can be fixed?

That's plain normal, IOW nothing to worry about.

ACPI idling causes huge changes in CPU power consumption which then
may result in some capacitors or coils "chatting" a bit too much ;)

Choosing CONFIG_HZ=1000 instead of CONFIG_HZ=100 (or the other way around?)
should help, as may the new dynticks option once it's become available
in mainline Linux kernel.
But I wouldn't decide changing those settings based on the capacitor chirping
only, it's much more useful to adjust those depending on your performance
criteria.

...unless the chirping is so high-pitched, loud and annoying that adapting
these things specifically for noise reduction is very desireable.

Oh, and I certainly don't recommend acpi=off for this: that's throwing
out the baby with the bathwater ;)

Andreas Mohr
