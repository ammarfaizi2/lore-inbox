Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313603AbSDHMoJ>; Mon, 8 Apr 2002 08:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313607AbSDHMoI>; Mon, 8 Apr 2002 08:44:08 -0400
Received: from [212.18.235.99] ([212.18.235.99]:60935 "EHLO street-vision.com")
	by vger.kernel.org with ESMTP id <S313603AbSDHMoH>;
	Mon, 8 Apr 2002 08:44:07 -0400
From: Justin Cormack <kernel@street-vision.com>
Message-Id: <200204081244.g38Ci4T17740@street-vision.com>
Subject: Re: Further WatchDog Updates
To: rob@osinvestor.com (Rob Radez)
Date: Mon, 8 Apr 2002 13:44:03 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204072342550.17511-100000@pita.lan> from "Rob Radez" at Apr 07, 2002 11:45:45 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Ok, new version of watchdog updates is up at
> http://osinvestor.com/bigwatchdog-4.diff

> 
> Please take a look at it, especially the documentation.
> 
> Regards,
> Rob Radez

ok for wafer5823wdt, which I wrote:

Timeout is a single byte, so should be in range 1-255 (and should probably be
a byte not an int...), not 1-3600.

All uses of waf_expect_close should be wrapped in
#ifndef CONFIG_WATCHDOG_NOWAYOUT, rather than just haveing it set to zero
if nowayout is not set. Saves a byte and makes it clearer. Though personally
I think the 'V' to close interface shouldnt be there at all. If you dont
want your watchdog to shut down, use no way out. If you do, then dont.

These may apply to other drivers too.

Justin
