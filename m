Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267534AbRHOV6S>; Wed, 15 Aug 2001 17:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267532AbRHOV6J>; Wed, 15 Aug 2001 17:58:09 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:38925 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S266982AbRHOV5x>; Wed, 15 Aug 2001 17:57:53 -0400
Message-ID: <3B7AF05C.29521C46@zip.com.au>
Date: Wed, 15 Aug 2001 14:57:48 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Georg Nikodym <georgn@somanetworks.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Dell I8000, 2.4.8-ac5 and APM
In-Reply-To: <997911115.7088.4.camel@keller>,
		<997911115.7088.4.camel@keller>  <997905442.2135.6.camel@keller> <997901702.2129.16.camel@keller> <29219.997909757@redhat.com> <30038.997911777@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> georgn@somanetworks.com said:
> >  To be honest, I don't really use suspend/resume so I can't answer.  I
> > did, however, get it working for myself while at OLS (under
> > 2.4.6-ext3). The trick there was remove my PCMCIA (3c59x) network card
> > and keep it in my knapsack for the duration of the conference.
> 
> This one has the built-in eepro100. That goes AWOL on suspend too, but
> that's solved by saving the PCI configuration space on suspend and
> restoring it on resume because their BIOS is too crap to do it for us.

Hum.  Current 3c59x.c will do that also if the `enable_wol=1' module
parm is provided.

I occasionally hear rumours about 3c59x failing with suspend/resume,
but It Works For Me and nobody has stepped up with a solid problem
description.  If someone _can_ reproduce this and is prepared to
work it a bit, please let me know.

-
