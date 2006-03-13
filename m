Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWCMLvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWCMLvP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 06:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbWCMLvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 06:51:15 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:59336 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP
	id S1751977AbWCMLvP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 06:51:15 -0500
Date: Mon, 13 Mar 2006 12:46:20 +0100 (CET)
To: linux-kernel@vger.kernel.org
Subject: Re: sis96x compiled in by error: delay of one minute at boot
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <u12nXjrl.1142250380.8654670.khali@localhost>
In-Reply-To: <20060313102721.76215.qmail@web26913.mail.ukl.yahoo.com>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Etienne Lorrain" <etienne_lorrain@yahoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.1.2 (zone4.gcu-squad.org [127.0.0.1]); Mon, 13 Mar 2006 12:46:21 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Etienne,

On 2006-03-13, Etienne Lorrain wrote:
> I just forgot to remove CONFIG_I2C_SIS96X=y in my kernel (minimum
> support possible for my PC hardware based on VIA, no module at all)
> and get a one minute delay at boot when trying to probe this non
> existing device in 2.6.16-rc5.
> Maybe the abscence test should be quicker.

The SIS96x SMBus is a PCI chip, so if it doesn't exist in a given
system, no code at all should be executed. So I have a hard time
believing it takes one minute. How do you know for sure that _this_
driver causing the delay? Did you actually try to rebuild without
CONFIG_I2C_SIS96X?

P.S.: The sensors list you tried to write to no more exists at this
address, see http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
instead.

--
Jean Delvare
