Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272032AbRHVPrw>; Wed, 22 Aug 2001 11:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272035AbRHVPrc>; Wed, 22 Aug 2001 11:47:32 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:38380 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S272032AbRHVPrb>;
	Wed, 22 Aug 2001 11:47:31 -0400
Date: Wed, 22 Aug 2001 16:47:29 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Chris Friesen <cfriesen@nortelnetworks.com>, Andi Kleen <ak@suse.de>
Cc: "Friesen, Christopher [CAR:VS16:EXCH]" <cfriesen@americasm01.nt.com>,
        linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: why no call to add_interrupt_randomness() on PPC?
Message-ID: <2428022792.998498849@[10.132.112.53]>
In-Reply-To: <3B83D1BA.1D8E507@nortelnetworks.com>
In-Reply-To: <3B83D1BA.1D8E507@nortelnetworks.com>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was looking at turning on SA_SAMPLE_RANDOM in
> our network driver, but then I realized that it would have no effect
> because it isn't even supported on PPC.

adding a call to add_interrupt_randomness() sounds like a good
idea if only for consistency and certainly does no harm (especially
if no net drivers use it), except that the timing is very coarsely
grained (jiffies) on PPC. It would be even better if you added
some cycle clock reading code to random.c for the PPC (in addition
to the i386 specific stuff) or better abstracted it all out into
arch directories.

Adding SA_SAMPLE_RANDOM to net devices: well, see other thread
ad-nauseam & make up your own mind :-)

--
Alex Bligh
