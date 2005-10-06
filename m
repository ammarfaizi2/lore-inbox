Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbVJFIaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbVJFIaG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 04:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbVJFIaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 04:30:06 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:36583 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750742AbVJFIaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 04:30:04 -0400
Date: Thu, 6 Oct 2005 10:30:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark Knecht <markknecht@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc3-rt9 - a few xruns misses
Message-ID: <20051006083043.GB21800@elte.hu>
References: <5bdc1c8b0510051615hfd77ba8pab7ee07bde13ffd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bdc1c8b0510051615hfd77ba8pab7ee07bde13ffd4@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Knecht <markknecht@gmail.com> wrote:

> Hi,
>    This is nothing particularily new. I'm just presenting it to 
> represent what I'm seeign and get some guidance about how to find out 
> what's going on.

lets first check whether all the RT priorities are set up correctly for 
your audio setup. Could you send me your /proc/interrupts, your .config 
and the output of:

  ps -eo pid,pri,rtprio,cmd

there are lots of built-in methods in the -rt kernel to figure out the 
source of latencies. If the default methods do not show anything then 
worst-case we can activate the kernel's latency tracer to record the 
actual xrun critical path.

	Ingo
