Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316106AbSHNXPQ>; Wed, 14 Aug 2002 19:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316089AbSHNXPQ>; Wed, 14 Aug 2002 19:15:16 -0400
Received: from dsl-213-023-038-048.arcor-ip.net ([213.23.38.48]:9666 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316088AbSHNXPP>;
	Wed, 14 Aug 2002 19:15:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: David Woodhouse <dwmw2@infradead.org>,
       Michael Knigge <Michael.Knigge@set-software.de>
Subject: Re: [ANNOUNCE] New PC-Speaker driver
Date: Thu, 15 Aug 2002 01:19:59 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Stas Sergeev <stssppnn@yahoo.com>, vda@port.imtp.ilyichevsk.odessa.ua,
       linux-kernel@vger.kernel.org
References: <20020814.11334845@knigge.local.net> <20850.1029327859@redhat.com> <E17f7LQ-0002XW-00@starship>
In-Reply-To: <E17f7LQ-0002XW-00@starship>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17f7Ql-0002Xb-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 August 2002 01:14, Daniel Phillips wrote:
> On Wednesday 14 August 2002 14:24, David Woodhouse wrote:
> > Michael.Knigge@set-software.de said:
> > > > Well, there is (currently) no intention to get it into the mainstream
> > > > kernel so don't treat it too seriously.
> > 
> > > Oh, I would love to see that thing in the Standard-Kernel....
> > 
> > Wait for people to stop using the 8254 timer for timer ticks, and you can 
> > have it all to yourself -- the timer abuse is the main reason the driver
> > was never suitable for inclusion.
> 
> Ah, if I recall correctly this technique uses a different timer channel
> from the timer tick.  What's the abuse?
>
> > Actually, now that HZ is easier to vary, you can switch it to a power of 2 
> > and use the RTC for it, again leaving you the 8254 for your own nefarious 
> > purposes.

Never mind, I realize it's the speeded up timer that's at issue.  Still, I
don't see what the problem is, just step it down to a suitable timer tick
speed, and it doesn't have to be an even division either.

-- 
Daniel
