Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265134AbUELRQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265134AbUELRQM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 13:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbUELRQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 13:16:12 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:28584 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S265134AbUELRQJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 13:16:09 -0400
Date: Wed, 12 May 2004 19:14:33 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: linux-kernel@vger.kernel.org, moqua@kurtenba.ch
Subject: Re: cpufreq and p4 prescott
Message-ID: <20040512171433.GA10481@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	linux-kernel@vger.kernel.org, moqua@kurtenba.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i have problems scaling down my p4 prescott 2.8 GHz.
You can't scale a prescott, you can only throttle it.

> [ck@holodeck:cpufreq] cat /proc/cpuinfo | grep Mhz
> cpu MHz         : 2807.131
> cpu MHz         : 2807.131
The cpu MHz entry in /proc/cpuinfo is the same for all CPUs, and no reliable
source to detect the current cpu frequency anyway. Use
/sys/devices/system/cpu/cpu0/scaling_cur_freq or even cpuinfo_cur_freq for
that.[*] So p4-clockmod-throttling does work on your p4 prescott.

	Dominik

[*] Available in 2.6.7, hopefully, if Linus merges the latest cpufreq-bk
tree from Dave. It'll be in the next -mm release, though.
