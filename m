Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267627AbRGUMxf>; Sat, 21 Jul 2001 08:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267629AbRGUMx0>; Sat, 21 Jul 2001 08:53:26 -0400
Received: from L0189P30.dipool.highway.telekom.at ([62.46.87.158]:48259 "EHLO
	mannix") by vger.kernel.org with ESMTP id <S267627AbRGUMxV>;
	Sat, 21 Jul 2001 08:53:21 -0400
Date: Sat, 21 Jul 2001 14:47:24 +0200
To: Sven Vermeulen <sven.vermeulen@rug.ac.be>
Cc: Linux-kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.7 build failure : esssolo1.c troubles
Message-ID: <20010721144724.A27527@aon.at>
In-Reply-To: <20010721142539.A6276@Zenith.starcenter>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010721142539.A6276@Zenith.starcenter>
User-Agent: Mutt/1.3.18i
From: Alexander Griesser <tuxx@aon.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, Jul 21, 2001 at 02:25:39PM +0200, you wrote:
> drivers/sound/sounddrivers.o: In function `solo1_probe':
> drivers/sound/sounddrivers.o(.text.init+0x3ab): undefined reference to \
>   `gameport_register_port'
> drivers/sound/sounddrivers.o: In function `solo1_remove':
> drivers/sound/sounddrivers.o(.text.init+0x4d7): undefined reference to \
>   `gameport_unregister_port'
> make: *** [vmlinux] Error 1

AFAIK, gameport_register_port and gameport_unregister_port are defined
in <linux/gameport.h>, which is included at the beginning of esssolo1.c
with the following code:

#if defined(CONFIG_INPUT_ANALOG) || defined(CONFIG_INPUT_ANALOG_MODULE)¶
#include <linux/gameport.h>¶
#else¶

Maybe one of those Values (CONFIG_INPUT_ANALOG{_MODULE, }) is not
defined?

regards, alexx
-- 
|   .-.   | Alexander Griesser <tuxx@aon.at> -=- ICQ:63180135 |  .''`. |
|   /v\   |  http://www.tuxx-home.at -=- Linux Version 2.4.6  | : :' : |
| /(   )\ |  FAQ zu at.linux:  http://alfie.ist.org/LinuxFAQ  | `. `'  |
|  ^^ ^^  `---------------------------------------------------´   `-   |
