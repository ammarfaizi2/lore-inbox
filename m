Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261411AbSLJNUr>; Tue, 10 Dec 2002 08:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261559AbSLJNUr>; Tue, 10 Dec 2002 08:20:47 -0500
Received: from mta9n.bluewin.ch ([195.186.1.215]:38207 "EHLO mta9n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S261411AbSLJNUq>;
	Tue, 10 Dec 2002 08:20:46 -0500
Date: Tue, 10 Dec 2002 14:28:14 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5][Trivial] VIA Rhine Kconfig entry
Message-ID: <20021210132814.GA10409@k3.hellgate.ch>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20021208003456.GA12234@k3.hellgate.ch> <3DF2B95E.5060706@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF2B95E.5060706@pobox.com>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.44 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Dec 2002 22:15:42 -0500, Jeff Garzik wrote:
> I agree about IO-APIC -- though I also think the reports that replacing 
> via-rhine with linuxfet, and changing nothing else, helps the situation.
> 
> It might be something cosmetic like silly dev->tx_timeout handling, or 
> it might be something useful like a chip-specific patch [often happens 
> with on-mobo chips] or even a north/south-bridge-specific fixup.

There are two different kinds of Rhine problems that are reportedly fixed
by turning apic support off:

a) No link, card's dead in the water
b) Netdev watchdog triggered despite recent Tx abort fix

No telling whether the cause is the same for both cases. I don't have
sufficient data on mobos or chip sets involved and where linuxfet helps. As
I am currently short on APIC hardware myself, I'll focus on clean ups and
improved diagnostics for now.

Roger
