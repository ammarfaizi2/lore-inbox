Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265977AbUGEJjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265977AbUGEJjd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 05:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266016AbUGEJjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 05:39:33 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:706 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S265977AbUGEJiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 05:38:07 -0400
Date: Mon, 5 Jul 2004 11:38:00 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: watchdog infrastructure
Message-ID: <20040705093800.GB5726@infomag.infomag.iguana.be>
References: <200407011923.45226.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407011923.45226.arnd@arndb.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

> I noticed you have been working on sanitizing the watchdog driver
> in your http://linux-watchdog.bkbits.net/linux-2.6-watchdog-experimental
> tree. What are your plans for this, i.e. do you see this as 2.7 only
> stuff or do you intend to merge the at least the infrastructure code
> so it can be used by future 2.6 drivers?

Plan is to build a generic watchdog driver that has a frame-work for all
watchdog drivers (or at least most of them). I think that it can be future
2.6 driver code. It's not a fundamental change :-).

> I'm asking because I have a new driver and I would prefer not to add
> yet another copy of the ioctl code, which I don't even know how
> to test properly.
> 
> If we can get your watchdog.c into a mergable state (in which it
> arguably isn't at the moment), I could use that to base my driver
> on, while the other drivers get converted during 2.7.

Good idea. I'm first going to test iit on my different hardware (pcwd  
+ i8xx + w83627hf). Once that's good enough we can start with the
generic watchdog driver and some converted drivers.

Did you have a look allready at the different watchdog operations in 
include/linux/watchdog.h ?

Greetings,
Wim.

