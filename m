Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267650AbRGUO5O>; Sat, 21 Jul 2001 10:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267651AbRGUO5E>; Sat, 21 Jul 2001 10:57:04 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.34]:34503 "HELO
	smtp2.pandora.be") by vger.kernel.org with SMTP id <S267650AbRGUO4v>;
	Sat, 21 Jul 2001 10:56:51 -0400
Date: Sat, 21 Jul 2001 16:56:52 +0200
From: Sven Vermeulen <sven.vermeulen@rug.ac.be>
To: Alexander Griesser <tuxx@aon.at>
Cc: Linux-kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.7 build failure : esssolo1.c troubles
Message-ID: <20010721165652.A10404@Zenith.starcenter>
Mail-Followup-To: Alexander Griesser <tuxx@aon.at>,
	Linux-kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20010721142539.A6276@Zenith.starcenter> <20010721144724.A27527@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010721144724.A27527@aon.at>; from tuxx@aon.at on Sat, Jul 21, 2001 at 02:47:24PM +0200
X-Operating-System: Linux 2.4.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, Jul 21, 2001 at 02:47:24PM +0200, Alexander Griesser wrote:
> AFAIK, gameport_register_port and gameport_unregister_port are defined
> in <linux/gameport.h>, which is included at the beginning of esssolo1.c
> with the following code:
> 
> #if defined(CONFIG_INPUT_ANALOG) || defined(CONFIG_INPUT_ANALOG_MODULE)¶
> #include <linux/gameport.h>¶
> #else¶

No(t anymore):

[snip from esssolo1.c]
#include <asm/uaccess.h>
#include <asm/hardirq.h>
#include <linux/gameport.h>
[snip]

gameport.h is automatically included AFAIK

-- 
 Sven Vermeulen            -    Key-ID CDBA2FDB 
 LUG: http://www.lugwv.be  -    http://www.keyserver.net

