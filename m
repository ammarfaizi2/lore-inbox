Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130748AbRAIURn>; Tue, 9 Jan 2001 15:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130370AbRAIURd>; Tue, 9 Jan 2001 15:17:33 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:48388 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129835AbRAIURT>; Tue, 9 Jan 2001 15:17:19 -0500
Date: Tue, 9 Jan 2001 12:15:43 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <Pine.LNX.4.30.0101092058090.8236-100000@e2>
Message-ID: <Pine.LNX.4.10.10101091212520.2331-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Jan 2001, Ingo Molnar wrote:
> 
>				 So i do believe that the networking
> code is properly designed in this respect, and this concept goes to the
> highest level of the networking code.

Absolutely. This is why I have no conceptual problems with the networking
layer changes, and why I am in violent disagreement with people who think
the networking layer should have used the (much inferior, in my opinion)
kiobuf/kiovec approach.

For people who worry about code re-use and argue for kiobuf/kiovec on
those grounds, I can only say that the code re-use should go the other
way. It should be "the bad code should re-use code from the good code". It
should NOT be "the new code should re-use code from the old code".

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
