Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271072AbRH2AS5>; Tue, 28 Aug 2001 20:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271129AbRH2ASr>; Tue, 28 Aug 2001 20:18:47 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:44228 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S271072AbRH2ASb>; Tue, 28 Aug 2001 20:18:31 -0400
Date: Wed, 29 Aug 2001 02:25:37 +0200 (CEST)
From: Pascal Schmidt <pleasure.and.pain@web.de>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Can't compile HiSaX into 2.2.20pre9 kernel
In-Reply-To: <Pine.LNX.4.33.0108290052010.8607-100000@neptune.sol.net>
Message-ID: <Pine.LNX.4.33.0108290222470.890-100000@neptune.sol.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2001, Pascal Schmidt wrote:

> The strange thing is, the drivers/isdn/isdn.a included above defines
> the symbol:
> /usr/src/linux-2.2.20pre9 # nm -a drivers/isdn/isdn.a | grep HiSax_setup
> 0000043c t HiSax_setup

Whooops, silly me. The problem is of course that the small "t" indicates
that HiSax_setup is a local symbol here, where it should be global and
shown as "T". It works with 2.2.19 because there HiSax_setup is a global
symbol.

Fix should be easy, though I don't know how to fix it. ;)

-- 
Ciao, Pascal

-<[ pharao90@tzi.de, netmail 2:241/215.72, home http://cobol.cjb.net/) ]>-

