Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbTJGJLQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 05:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbTJGJLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 05:11:16 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:17145 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262004AbTJGJLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 05:11:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16258.33584.782470.863660@gargle.gargle.HOWL>
Date: Tue, 7 Oct 2003 11:11:12 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test6 APM/IDE double-suspend weirdness
In-Reply-To: <20031002125141.GB205@openzaurus.ucw.cz>
References: <16248.9932.145681.897552@gargle.gargle.HOWL>
	<20031002125141.GB205@openzaurus.ucw.cz>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek writes:
 > Hi!
 > 
 > > In test6 (and test5 and possibly earlier), when suspending
 > > my aging Latitude with APM, the machine turns off, only to
 > > turn itself on again one second later with the disk spinning
 > > up. Then it turns itself off again a second later.
 > > 
 > > The kernel log contains:
 > > hda: start_power_step(step: 0)
 > > hda: start_power_step(step: 1)
 > > hda: complete_power_step(step: 1, stat: 50, err: 0)
 > > hda: completing PM request, suspend
 > > 
 > > Apart from this, both APM suspend and resume work fine.
 > 
 > Try removing pm_send_all from apm.c

Ok I tried removing all pm_send_all from apm.c.
I made no difference at all. I suspect the driver
model stuff or the IDE layer is at fault here.

/Mikael
