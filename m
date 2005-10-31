Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbVJaRQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbVJaRQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 12:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbVJaRQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 12:16:58 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:54503 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932465AbVJaRQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 12:16:57 -0500
Subject: Re: [BUG 2579] linux 2.6.* sound problems
From: Lee Revell <rlrevell@joe-job.com>
To: patrizio.bassi@gmail.com
Cc: "Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <436638A8.3000604@gmail.com>
References: <436638A8.3000604@gmail.com>
Content-Type: text/plain
Date: Mon, 31 Oct 2005 12:15:28 -0500
Message-Id: <1130778928.32101.60.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-31 at 16:30 +0100, Patrizio Bassi wrote:
> starting from 2.6.0 (2 years ago) i have the following bug.
> 
> link: http://bugzilla.kernel.org/show_bug.cgi?id=2579
> and https://bugtrack.alsa-project.org/alsa-bug/view.php?id=230
> 
> fast summary:
> when playing audio and using a bit the harddisk (i.e. md5sum of a 200mb
> file)
> i hear noises, related to disk activity. more hd is used, more chicks
> and ZZZZ noises happen.
> 
> linux 2.4.x and windows has no problems, perfect.
> tried module/standalone alsa drivers.

Your problem is a "singing capacitor", caused by cheap motherboard
components.  The problem appeared in 2.6.0 because that's when the timer
frequency changed from 100HZ to 1000HZ.

Starting with 2.6.14 you can work around this by compiling with HZ set
to 250 or 100.  But it's fundamentally a hardware problem.

Lee

