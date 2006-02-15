Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWBOST7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWBOST7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 13:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWBOST7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 13:19:59 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:62894 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751215AbWBOST6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 13:19:58 -0500
Subject: Re: [BUG] kernel 2.6.15.4: soft lockup detected on CPU#0!
From: Lee Revell <rlrevell@joe-job.com>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: Charles-Edouard Ruault <ce@ruault.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060215150710.GN30182@vanheusden.com>
References: <43EF8388.10202@ruault.com>
	 <20060214114102.GC20975@vanheusden.com>
	 <1139934749.11659.97.camel@mindpipe>
	 <20060215150710.GN30182@vanheusden.com>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 13:19:52 -0500
Message-Id: <1140027592.2733.38.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-15 at 16:07 +0100, Folkert van Heusden wrote:
> 
> So it seems it switches back to pio somewhere in time.
> 
> But on the other hand: shouldn't pio run ok as well without softlockup
> errors? 

AFAICT in PIO mode if a huge IO request is submitted and/or the device
is slow to respond there's nothing to prevent us spending a long time in
the IDE driver.

IIRC this can't be made preemptible due to data corruption issues on
some hardware.  Maybe we should touch the watchdog in there.

Lee

