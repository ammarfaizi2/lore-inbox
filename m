Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbUC2ShN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 13:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbUC2ShN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 13:37:13 -0500
Received: from mail6.bluewin.ch ([195.186.4.229]:10407 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S262756AbUC2ShK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 13:37:10 -0500
Date: Mon, 29 Mar 2004 20:36:58 +0200
From: Roger Luethi <rl@hellgate.ch>
To: walt <wa1ter@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Via-Rhine ethernet driver problem?
Message-ID: <20040329183658.GA28252@k3.hellgate.ch>
Mail-Followup-To: walt <wa1ter@myrealbox.com>,
	linux-kernel@vger.kernel.org
References: <40685BC9.1040902@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40685BC9.1040902@myrealbox.com>
X-Operating-System: Linux 2.6.3 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2004 09:24:25 -0800, walt wrote:
> ECS K7VTA3 motherboard with built-in ethernet chip:
> 
> 00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 
> 74)
> 
> [...]
>
> I also discovered by using 'scp' to copy files between machines that the bad
> performance is assymetrical:  copying a file *to* this machine runs at about
> half-speed (5 MB/sec) whereas copying a file *from* this machine runs at
> 45 KiloB/sec, about one percent of expected.
> 
> The reason I feel this is software and not hardware is that the same machine
> running any of the BSD's runs full-speed in both directions.

If you have ACPI and/or IO-APIC enabled, does the behavior change if
you turn them off? Any info in the kernel log? If not, what if you
change the driver's debug level to 3? Is the slow transfer rate
the result of short, fast bursts or actual sustained throughput at
45 KB/sec?

Roger
