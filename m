Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbVANOqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbVANOqp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 09:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbVANOqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 09:46:45 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:11748 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S262002AbVANOqk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 09:46:40 -0500
Date: Fri, 14 Jan 2005 15:40:31 +0100 (CET)
To: pioppo@ferrara.linux.it
Subject: Re: 2.6.10-mm2: it87 sensor driver stops CPU fan
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <g7Idbr9m.1105713630.9207120.khali@localhost>
In-Reply-To: <20050113232904.GC2458@kroah.com>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Greg KH" <greg@kroah.com>, "Jonas Munsin" <jmunsin@iki.fi>, djg@pdp8.net,
       "LM Sensors" <sensors@Stimpy.netroedge.com>,
       "LKML" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Simone,

> On Thu, Jan 13, 2005 at 12:27:35AM +0200, Jonas Munsin wrote:
> > Here is it87.c_2.6.10-jm4-detect_broken_bios_20050112.diff implementing
> > this. It goes on top of the previous patch.
> >
> > - detects broken bioses, disables the pwm for them and prints a message
> > - fixes an unrelated minor bug in set_fan_div()
> >
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Signed-off-by: Jonas Munsin <jmunsin@iki.fi>
>
> Applied, thanks.

Kernel 2.6.11-rc1-mm1 is just out, which does contain the latest updates
to the it87 driver. I would like you to test them. What you should see:

1* When loading the it87 driver, the fans should not change speeds.

2* In the logs, you should see an information line with the chip type,
address and revision.

3* Still in the logs, you should see a warning about your BIOS being
broken and PWM being disabled as a consequence.

4* PWM interface should NOT be available in sysfs.

As soon as you will have confirmed that everything worked as expected,
Jonas and I will provide a patch adding a pwm polarity reconfiguration
module parameter for you to test. This should give you access to the PWM
features of your it87 chip again, but in a safe way for a change ;)

Thanks,
--
Jean Delvare
