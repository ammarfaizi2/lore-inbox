Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVE3LQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVE3LQP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 07:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVE3LQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 07:16:14 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:41147
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261438AbVE3LPN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 07:15:13 -0400
Subject: Re: RT patch acceptance
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@muc.de>, Takashi Iwai <tiwai@suse.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       bhuey@lnxw.com, nickpiggin@yahoo.com.au, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050530103347.GA13425@elte.hu>
References: <1117044019.5840.32.camel@sdietrich-xp.vilm.net>
	 <20050526193230.GY86087@muc.de> <20050526200424.GA27162@elte.hu>
	 <20050527123529.GD86087@muc.de> <20050527124837.GA7253@elte.hu>
	 <20050527125630.GE86087@muc.de> <20050527131317.GA11071@elte.hu>
	 <20050527133122.GF86087@muc.de> <s5hwtpkwz4z.wl@alsa2.suse.de>
	 <20050530095349.GK86087@muc.de>  <20050530103347.GA13425@elte.hu>
Content-Type: text/plain
Organization: linutronix
Date: Mon, 30 May 2005 13:15:41 +0200
Message-Id: <1117451741.14566.5.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-30 at 12:33 +0200, Ingo Molnar wrote:

> FYI, to get good latencies for jack you currently need the -RT tree and 
> CONFIG_PREEMPT. (see Lee Revell's and Rui Nuno Capela's extensive tests)
> 
> In other words, cond_resched() in might_sleep() (PREEMPT_VOLUNTARY, 
> which i announced Jul 9 last year) is _not_ good enough for 
> advanced-audio (jack) users. PREEMPT_VOLUNTARY is mostly good enough for 
> simple audio playback / gaming.

It's neither good enough for a lot of embedded applications, but _RT is.

tglx


