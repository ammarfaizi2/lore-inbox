Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUJ3Hio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUJ3Hio (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 03:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbUJ3Hio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 03:38:44 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:33505 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S263626AbUJ3Hin
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 03:38:43 -0400
Date: Sat, 30 Oct 2004 09:38:43 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: davej@codemonkey.org.uk, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] small cpufreq cleanup
Message-ID: <20041030073843.GA8075@dominikbrodowski.de>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	davej@codemonkey.org.uk, cpufreq@www.linux.org.uk,
	linux-kernel@vger.kernel.org
References: <20041030072246.GG4374@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041030072246.GG4374@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 09:22:46AM +0200, Adrian Bunk wrote:
> the patch below does the following cleanups in the cpufreq code:
> - remove the __deprecated cpufreq_set{,max} functions that didn't have
>   any users left

Not yet, the #warning says it'll be removed 2005-01-01.

> - make cpufreq_gov_dbs static

Patch which does that is already in cpufreq-bk.

> cpufreq_driver_target and cpufreq_governor in drivers/cpufreq/cpufreq.c 
> also both have currently exactly zero in-kernel users, but I left them.

cpufreq_driver_target and/or cpufreq_governor should already be used by some
code, but aren't yet, but definitely will be useful and used soon.

	Dominik
