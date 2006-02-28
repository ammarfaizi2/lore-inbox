Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWB1KEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWB1KEx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 05:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWB1KEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 05:04:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20121 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750738AbWB1KEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 05:04:52 -0500
Date: Tue, 28 Feb 2006 02:03:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Peter Hagervall <hager@cs.umu.se>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, garloff@suse.de
Subject: Re: Linux v2.6.16-rc5 - regression
Message-Id: <20060228020336.79616850.akpm@osdl.org>
In-Reply-To: <20060228093846.GA24867@brainysmurf.cs.umu.se>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
	<20060228093846.GA24867@brainysmurf.cs.umu.se>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Hagervall <hager@cs.umu.se> wrote:
>
> In -rc5 the printk timing numbers do not reset to [    0.000000] upon
>  boot.

What numbers are you getting now?

> This worked in -rc4 and so I started bisecting and git came up
>  with:
> 
>  commit 9827b781f20828e5ceb911b879f268f78fe90815
>  Author: Kurt Garloff <garloff@suse.de>
>  Date:   Mon Feb 20 18:27:51 2006 -0800
> 
>  	[PATCH] OOM kill: children accounting
> 
>  I can't see why that would break the timing information, but I'll just
>  assume that git was right, and tell you guys.

Well yes, it'll be something else - perhaps some TSC change or something. 
We'd need to know what architecture you're using...

Anwyay, these numbers aren't supposed to measure anything absolute like
uptime - they're purely for relative timing.  It would be nice to get them
increasing monotonically from zero, but we wouldn't bust a gut to achieve
that - it's just a debugging thing.
