Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267435AbTAQIwq>; Fri, 17 Jan 2003 03:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267437AbTAQIwq>; Fri, 17 Jan 2003 03:52:46 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:36603 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S267435AbTAQIwp>; Fri, 17 Jan 2003 03:52:45 -0500
Date: Fri, 17 Jan 2003 10:02:37 +0100
From: Dominik Brodowski <linux@brodo.de>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, akpm@diego.com
Subject: Re: [PATCH] linux-2.5.59_timer-tsc-cleanup_A0
Message-ID: <20030117090237.GA1523@brodo.de>
References: <1042771949.29942.19.camel@w-jstultz2.beaverton.ibm.com> <22767.1042793253@www52.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22767.1042793253@www52.gmx.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Fri, Jan 17, 2003 at 09:47:33AM +0100, john stultz wrote:
> Linus, Andrew, All,
>         Just a resend/resync for 2.5.59. This patch cleans up the
> timer_tsc code, removing the unused use_tsc variable and making
> fast_gettimeoffset_quotient static.

use_tsc is _not_ unused -- it's used at least in time_cpufreq_notifier (even
though time_cpufreq_notifier didn't introduce use_tsc, it's in there the
same way it's in 2.4. time.c ). So please don't remove it.

	Dominik
