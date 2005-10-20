Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbVJTShg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVJTShg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 14:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbVJTShg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 14:37:36 -0400
Received: from ms004msg.fastwebnet.it ([213.140.2.58]:11668 "EHLO
	ms004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750763AbVJTShg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 14:37:36 -0400
Date: Thu, 20 Oct 2005 20:37:24 +0200
From: Mattia Dongili <malattia@linux.it>
To: Chris Boot <bootc@bootc.net>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Reiser4 lockups (no oops)
Message-ID: <20051020183724.GA3999@inferi.kami.home>
Mail-Followup-To: Chris Boot <bootc@bootc.net>, Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org
References: <43567D80.3050304@bootc.net> <20051020131815.GI2811@suse.de> <20051020163425.z7wygjyir8lcw0gk@horde.fusednetworks.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051020163425.z7wygjyir8lcw0gk@horde.fusednetworks.co.uk>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.14-rc4-mm1-2 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2005 at 04:34:25PM +0100, Chris Boot wrote:
> Quoting Jens Axboe <axboe@suse.de>:
> 
> >On Wed, Oct 19 2005, Chris Boot wrote:
> >>I don't get any OOPSes or BUGs or anything, not on my screen nor on my
> >>serial console (although I'm not sure I have this working right--I only
> >>seem to get kernel boot messages). Machine replies to pings but I can't
> >
> >Easy fix for that is probably to kill klogd on the machine. Test with eg
> >loading/unloading of loop, that prints a message when it loads.
> 
> I'd love to, but the machine is locked solid and won't turn on the display 
> or
> switch TTYs or anything. Anyway, I've applied reiser4-fix-livelock.patch 
> from
> ftp.namesys.org and so far so good (over night).

aah! nice, those also fix the apt-get freeze I've been having from some
mm kernels ago.

I also managed to get the trace of apt-get freezing by means of Sysrq+P
but I stupidly forgot the fs was readonly so I didn't dump dmesg :P
I can easily reproduce it if anyone is interested.

> I see there's now a reiser4-fix-livelock-2.patch, anybody know the 
> differences?

don't know, I'd try the -2 patches also, they seem a different version
of the same fix/cleanup.

-- 
mattia
:wq!
