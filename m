Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283805AbRK3VfR>; Fri, 30 Nov 2001 16:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283807AbRK3VfI>; Fri, 30 Nov 2001 16:35:08 -0500
Received: from cp1s4p1.dashmail.net ([216.36.32.37]:27152 "EHLO sr71.net")
	by vger.kernel.org with ESMTP id <S283805AbRK3Vey>;
	Fri, 30 Nov 2001 16:34:54 -0500
Message-ID: <3C07FB73.9030708@sr71.net>
Date: Fri, 30 Nov 2001 13:34:43 -0800
From: "David C. Hansen" <dave@sr71.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011129
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [LART] pc_keyb.c changes
In-Reply-To: <Pine.GSO.4.21.0111300252030.13367-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:

> 	Could the person who switched from BKL to spin_lock_irqsave() in
> pc_keyb.c please share whatever the hell he had been smoking?  Free clue:
> disabling interrupts for long intervals to improve scalability is right up
> there with fighting for peace and fucking for virginity.
As I slowly raise my hand to take, um credit....


This is definitely one of the drivers I to take a second look at, now 
that I know about the BKL being held for block and char device opens. 
Do you have any ideas how else to do this safely since aux_count is 
referenced during an interrupt?

--
Dave Hansen
dave@sr71.net


