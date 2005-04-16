Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262668AbVDPO2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbVDPO2f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 10:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbVDPO2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 10:28:35 -0400
Received: from gate.crashing.org ([63.228.1.57]:14801 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262668AbVDPO2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 10:28:33 -0400
Subject: Re: [PATCH] ppc64: improve g5 sound headphone mute
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <jek6n2x4m0.fsf@sykes.suse.de>
References: <1113282436.21548.42.camel@gaston>
	 <jell7nu6yk.fsf@sykes.suse.de> <1113344225.21548.108.camel@gaston>
	 <jey8bnk4lj.fsf@sykes.suse.de> <1113345561.5387.114.camel@gaston>
	 <jed5szk3gh.fsf@sykes.suse.de> <1113347296.5388.121.camel@gaston>
	 <je8y3nk117.fsf@sykes.suse.de> <1113350355.5387.129.camel@gaston>
	 <jefyxvruip.fsf@sykes.suse.de> <1113391382.5463.20.camel@gaston>
	 <jek6n2x4m0.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Sun, 17 Apr 2005 00:27:01 +1000
Message-Id: <1113661621.5516.267.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-16 at 14:56 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > This patch fixes a couple more issues with the management of the GPIOs
> > dealing with headphone and line out mute on the G5. It should fix the
> > remaining problems of people not getting any sound out of the headphone
> > jack.
> 
> There's still a minor problem: when booting with line-out plugged (didn't
> try headphone yet) the initial volume settings are still not right.
> Unplugging and plugging again fixes this.

It can be either alsa not restoring the setup properly, or a bug in the
driver I'm still chasing where the headphone detection happens before
propoer initialisation of the rest of the driver ...



