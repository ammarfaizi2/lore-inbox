Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131998AbQKVQS6>; Wed, 22 Nov 2000 11:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132030AbQKVQSs>; Wed, 22 Nov 2000 11:18:48 -0500
Received: from nathan.polyware.nl ([193.67.144.241]:44548 "EHLO
        nathan.polyware.nl") by vger.kernel.org with ESMTP
        id <S131998AbQKVQSq>; Wed, 22 Nov 2000 11:18:46 -0500
Date: Wed, 22 Nov 2000 16:48:42 +0100
From: Pauline Middelink <middelink@polyware.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.2.18-pre19 asm/delay.h problem?
Message-ID: <20001122164842.A3420@polyware.nl>
Mail-Followup-To: Pauline Middelink <middelin@polyware.nl>,
        linux-kernel@vger.kernel.org
In-Reply-To: <E13yNHb-0005O4-00@the-village.bc.nu> <200011220957.KAA26634@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200011220957.KAA26634@cave.bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Wed, Nov 22, 2000 at 10:57:53AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2000 around 10:57:53 +0100, Rogier Wolff wrote:
[skip]

> .... Inside a #if 0. This question keeps on popping up, and people
> seem to be able to grep for definitions of stuff well enough. Then
> near the definition you can explain this. It's a form of documenting
> this "trick"...
> 
> #if 0
> /* Note: This definition is not for real. The idea about __bad_udelay is
> that you get a compile-time error if you call udelay with a number of 
> microseconds that is too large for udelay. There is mdelay if you need 
> delays on the order of miliseconds. Please update the places where
> udelay is called with this large constant!
> 
> If you change the #if 0 to #if 1, the stuff you're trying to compile will
> compile, but you'll crash your system when it's used.
> */
> 
> #define __bad_udelay() panic("Udelay called with too large a constant")
> #endif

I want to bed that somebody will post a "fix" which will patch
the #if 0 to 1. :)

    Met vriendelijke groet,
        Pauline Middelink
-- 
PGP Key fingerprint = DE 6B D0 D9 19 AD A7 A0  58 A3 06 9D B6 34 39 E2
For more details look at my website http://www.polyware.nl/~middelink
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
