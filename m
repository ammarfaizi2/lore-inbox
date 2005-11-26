Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbVKZPFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbVKZPFc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 10:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVKZPFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 10:05:32 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:299 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S932169AbVKZPFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 10:05:31 -0500
Date: Sat, 26 Nov 2005 16:03:09 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Ingo Molnar <mingo@elte.hu>
cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] warn-on-once.patch
In-Reply-To: <20051126145216.GB12999@elte.hu>
Message-ID: <Pine.LNX.4.63.0511261559130.14096@gockel.physik3.uni-rostock.de>
References: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com>
 <20051122013522.18537.97944.sendpatchset@cog.beaverton.ibm.com>
 <20051126145216.GB12999@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define WARN_ON_ONCE(condition)		\
> +do {					\
> +	static int warn_once = 1;	\
> +					\
> +	if (condition) {		\
> +		warn_once = 0;		\
> +		WARN_ON(1);		\
> +	}				\
> +} while (0);
              ^
Is the semicolon intentional?

Tim
