Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268135AbUHFNfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268135AbUHFNfz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 09:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268137AbUHFNfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 09:35:55 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:60392 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268135AbUHFNfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 09:35:52 -0400
Message-ID: <d577e56904080606356289c105@mail.gmail.com>
Date: Fri, 6 Aug 2004 09:35:51 -0400
From: Patrick McFarland <diablod3@gmail.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ACK and Packet Queues
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do Linux packet schedulers also queue and allow prioritization ACK responses?

I just spent the last hour googling for an answer to my question, and
I can't find one, and I thought I'd ask here, possibly someone who
understands the packet queuing code is subscribed.

I'm asking because I'm trying to find a good way to influence what
packets are sent to me over a slow link. I'm thinking along the lines
of mangling TOS on incoming AND outgoing packets of SomeService,
saying I want them to be Minimize-Delay, and having the ACK of the
incoming packets of SomeService be Minimize-Delay as well, so that
SomeService ACKs are sent before other ACKs, just like SomeService
normal outgoing packets would be.

Because I would be now Minimize-Delay-ing all incoming and outgoing
traffic of SomeServce, it would increase the chances of me getting
SomeService traffic over other traffic (or so I hope.)

This all depends, of course, if Linux's packet scheduler also
schedules ACKs (and allows me to prioritize them).

-- 
Patrick "Diablo-D3" McFarland || diablod3@gmail.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, we'd 
all be running around in darkened rooms, munching magic pills and listening to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989
