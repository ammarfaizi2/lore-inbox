Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277137AbRJDGrH>; Thu, 4 Oct 2001 02:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277029AbRJDGq5>; Thu, 4 Oct 2001 02:46:57 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:12220 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S277014AbRJDGqv>;
	Thu, 4 Oct 2001 02:46:51 -0400
Message-ID: <3BBC05EC.AA9BFB4F@candelatech.com>
Date: Wed, 03 Oct 2001 23:47:08 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jamal <hadi@cyberus.ca>
CC: Simon Kirby <sim@netnation.com>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, netdev@oss.sgi.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.GSO.4.30.0110032057000.8016-100000@shell.cyberus.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:
> 
> On Wed, 3 Oct 2001, Simon Kirby wrote:
> 
> > On Wed, Oct 03, 2001 at 09:33:12AM -0700, Linus Torvalds wrote:
> >
> > Actually, the way I first started looking at this problem is the result
> > of a few attacks that have happened on our network.  It's not just a
> > while(1) sendto(); UDP spamming program that triggers it -- TCP SYN
> > floods show the problem as well, and _there is no way_ to protect against
> > this without using syncookies or some similar method that can only be
> > done on the receiving TCP stack only.
> >
> > At one point, one of our webservers received 30-40Mbit/sec of SYN packets
> > sustained for almost 24 hours.  Needless to say, the machine was not
> > happy.
> >
> 
> I think you can save yourself a lot of pain today by going to a "better
> driver"/hardware. Switch to a tulip based board; in particular one which
> is based on the 21143 chipset. Compile in hardware traffic control and
> save yourself some pain.

The tulip driver only started working for my DLINK 4-port NIC
after about 2.4.8, and last I checked the ZYNX 4-port still refuses
to work, so I wouldn't consider it a paradigm of
stability and grace quite yet.  Regardless of that, it is often
impossible to trade NICS (think built-in 1U servers), and claiming
to only work correctly on certain hardware (and potentially lock up
hard on other hardware) is a pretty sorry state of affairs...

Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
