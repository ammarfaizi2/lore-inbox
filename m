Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWEHHIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWEHHIM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 03:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWEHHIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 03:08:12 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:48522
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932353AbWEHHIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 03:08:11 -0400
Date: Mon, 08 May 2006 00:07:54 -0700 (PDT)
Message-Id: <20060508.000754.06312852.davem@davemloft.net>
To: pavel@suse.cz
Cc: mpm@selenic.com, tytso@mit.edu, mrmacman_g4@mac.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network
 drivers
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060508062604.GD5765@ucw.cz>
References: <20060506.170810.74552888.davem@davemloft.net>
	<20060507045920.GH15445@waste.org>
	<20060508062604.GD5765@ucw.cz>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek <pavel@suse.cz>
Date: Mon, 8 May 2006 06:26:05 +0000

> > Then I'll run my test on one of the various arches where HZ=~100 and
> > we don't have a TSC. Like Sparc?
> > 
> >   /* XXX Maybe do something better at some point... -DaveM */
> >   typedef unsigned long cycles_t;
> >   #define get_cycles()    (0)
> 
> Seems like sparc32 is broken :-(, and probably broken terminally...
> there are very little randomness sources that can handle 10msec
> sampling period :-(.
> 
> Maybe we should disable /dev/random on sparc32?

What do other platforms without a TSC do?
