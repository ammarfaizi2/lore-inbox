Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319339AbSHNXaa>; Wed, 14 Aug 2002 19:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319340AbSHNXaa>; Wed, 14 Aug 2002 19:30:30 -0400
Received: from ppp77-4-71.miem.edu.ru ([194.226.32.71]:7297 "EHLO null.ru")
	by vger.kernel.org with ESMTP id <S319339AbSHNXa3>;
	Wed, 14 Aug 2002 19:30:29 -0400
Message-ID: <3D5AE7BB.5040005@yahoo.com>
Date: Thu, 15 Aug 2002 03:28:59 +0400
From: Stas Sergeev <stssppnn@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: ru, en
MIME-Version: 1.0
To: Andrew Rodland <arodland@noln.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] New PC-Speaker driver
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Andrew Rodland wrote:
> I can get some pretty decent sound out of it, but I also get some
> horrible noise. Even if I send the driver a stream of zeroes, as soon
> as it's opened it starts generating some horrible clicks and a
> high-pitched whine.
> Do I blame my motherboard (actually, a laptop)?
Yes because for most people it works pretty
fine:)

> Is there any way to fix this, or at least improve it?
Well, it was reported that CONFIG_APM_CPU_IDLE
causes such noises on some machines and even
CONFIG_APM_ALLOW_INTS doesn't fix the problem.
I have included a workaround that disables idle calls
during a playback. Are you using the latest patch from
my page (for 2.4.19 now)?
Also try disabling APM manually. If this doesn't
help then this is another problem but anyway someone is
disabling interrups for the large periods, (hopefully)
only this can cause such an effect. Make sure that
the hard drive is not active during a playback
because it also distorts sound by disabling interrupts
for too long.

