Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129648AbQKHSSC>; Wed, 8 Nov 2000 13:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129650AbQKHSRw>; Wed, 8 Nov 2000 13:17:52 -0500
Received: from adsl-63-194-89-126.dsl.snfc21.pacbell.net ([63.194.89.126]:18700
	"HELO skull.piratehaven.org") by vger.kernel.org with SMTP
	id <S129648AbQKHSRr>; Wed, 8 Nov 2000 13:17:47 -0500
Date: Wed, 8 Nov 2000 10:12:48 -0800
From: Brian Pomerantz <bapper@piratehaven.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Pentium 4 and 2.4/2.5
Message-ID: <20001108101248.A8902@skull.piratehaven.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E13tZMe-0000F8-00@the-village.bc.nu> <Pine.LNX.4.10.10011080953130.16579-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.LNX.4.10.10011080953130.16579-100000@penguin.transmeta.com>
X-homepage: http://www.piratehaven.org/~bapper/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2000 at 10:10:45AM -0800, Linus Torvalds wrote:
> 
> Now, I could imagine that Intel would select an instruction that didn't
> work on Athlon on purpose, but I really don't think they did.  I don't
> have an athlon to test.
> 
> It's easy enough to generate a test-program. If the following works,
> you're pretty much guaranteed that it's ok
> 
> 	int main()
> 	{
> 		printf("Testing 'rep nop' ... ");
> 		asm volatile("rep ; nop");
> 		printf("okey-dokey\n"); 
> 		return 0;
> 	}
> 
> (there's not much a "rep nop" _can_ do, after all - the most likely CPU
> extension would be to raise an "Illegal Opcode" fault).
> 

Just for the curious, this works on Athlons. :)


BAPper
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
