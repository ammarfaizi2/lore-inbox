Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277263AbRJDXZi>; Thu, 4 Oct 2001 19:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277203AbRJDXZ2>; Thu, 4 Oct 2001 19:25:28 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:18607 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S277251AbRJDXZQ>;
	Thu, 4 Oct 2001 19:25:16 -0400
Date: Fri, 05 Oct 2001 00:25:41 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Simon Kirby <sim@netnation.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Message-ID: <309761448.1002241541@[195.224.237.69]>
In-Reply-To: <20011004150119.B2373@netnation.com>
In-Reply-To: <20011004150119.B2373@netnation.com>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Thursday, 04 October, 2001 3:01 PM -0700 Simon Kirby 
<sim@netnation.com> wrote:

> Ingo is not limiting interrupts to make it drop packets and forget things
> just so that userspace can proceed.  Instead, he is postponing servicing
> of the interrupts so that the card can batch up more packets and the
> interrupt will retrieve more at once rather than continually leaving and
> entering the interrupt to just pick up a few packets.  Without this, the
> interrupt will starve everything else, and nothing will get done.

Ah OK. in this case already looking at interupt coalescing at firmware
level which mitigates this 'earlier on', however even this
stratgy fails at higher pps levels => i.e. in these circumstances
the card buffer is already full-ish, as the interrupt has already been
postponed, and postponing it further can only cause dropped packets
through buffer overrun.

--
Alex Bligh
