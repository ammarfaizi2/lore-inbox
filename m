Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbWALCgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbWALCgx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 21:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932679AbWALCgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 21:36:53 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:36001 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932678AbWALCgw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 21:36:52 -0500
Subject: Re: [PATCH 4/10] NTP: precalculate time_adj from frequency
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0512220022010.30903@scrub.home>
References: <Pine.LNX.4.61.0512220022010.30903@scrub.home>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 18:36:44 -0800
Message-Id: <1137033405.2890.107.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-22 at 00:22 +0100, Roman Zippel wrote:
> This adds the frequency part to ntp_update_frequency(). It basically
> calculates from tick_usec and time_freq how many nsec the time should be
> advanced per second and converts it into the nsec and fraction per tick
> (tick_nsec and time_adj).
> Precalculating these values allows to be more precise and avoids the
> crude time_freq to time_adj conversion in second_overflow().

This patch looks ok as well, although would you consider renaming
time_adj to something like phase_adj? Also maybe include a larger
comment about how tick_nsec and phase_adj store the ntp adjustment, just
to make it obvious that they are the cumulative result of the adjtimex()
offset, freq, tick and singleshot offset values?


thanks
-john


