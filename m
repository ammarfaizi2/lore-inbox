Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271848AbRH1RNH>; Tue, 28 Aug 2001 13:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271851AbRH1RM6>; Tue, 28 Aug 2001 13:12:58 -0400
Received: from ntt-connection.daiwausa.com ([210.175.188.3]:11733 "EHLO
	ead42.ead.dsa.com") by vger.kernel.org with ESMTP
	id <S271848AbRH1RMn>; Tue, 28 Aug 2001 13:12:43 -0400
Date: Tue, 28 Aug 2001 13:12:29 -0400
From: "Bill Rugolsky Jr." <rugolsky@ead.dsa.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andreas Schwab <schwab@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Message-ID: <20010828131229.G9945@ead45>
In-Reply-To: <Pine.LNX.4.33.0108280617250.8365-100000@penguin.transmeta.com> <3B8BA883.3B5AAE2E@linux-m68k.org> <je4rqsdv4z.fsf@sykes.suse.de> <3B8BCB1B.9C4B35C0@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3B8BCB1B.9C4B35C0@linux-m68k.org>; from zippel@linux-m68k.org on Tue, Aug 28, 2001 at 06:47:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2001 at 06:47:23PM +0200, Roman Zippel wrote:
> Ok, it uses an assignment, but it has almost the same effect (except for
> pointer/integer values).
 
Wrong.  A cast throws away information, making meaningful warnings impossible.
The assignment allows the compiler to apply the usual C integral
promotions and catch narrowing and non-value-preserving conversions,
like unsigned int to int, or an even more common bug, unsigned int to
long, which behaves differently depending on whether long is 32 or 64
bits.

Regards,

   Bill Rugolsky
