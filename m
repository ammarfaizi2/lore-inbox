Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWEHHBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWEHHBi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 03:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWEHHBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 03:01:38 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46093 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932344AbWEHHBi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 03:01:38 -0400
Date: Mon, 8 May 2006 06:26:05 +0000
From: Pavel Machek <pavel@suse.cz>
To: Matt Mackall <mpm@selenic.com>
Cc: "David S. Miller" <davem@davemloft.net>, tytso@mit.edu,
       mrmacman_g4@mac.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Message-ID: <20060508062604.GD5765@ucw.cz>
References: <20060505203436.GW15445@waste.org> <20060506115502.GB18880@thunk.org> <20060506164808.GY15445@waste.org> <20060506.170810.74552888.davem@davemloft.net> <20060507045920.GH15445@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060507045920.GH15445@waste.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Then I'll run my test on one of the various arches where HZ=~100 and
> we don't have a TSC. Like Sparc?
> 
>   /* XXX Maybe do something better at some point... -DaveM */
>   typedef unsigned long cycles_t;
>   #define get_cycles()    (0)

Seems like sparc32 is broken :-(, and probably broken terminally...
there are very little randomness sources that can handle 10msec
sampling period :-(.

Maybe we should disable /dev/random on sparc32?
-- 
Thanks for all the (sleeping) penguins.
