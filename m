Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQKPB0n>; Wed, 15 Nov 2000 20:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129094AbQKPB0d>; Wed, 15 Nov 2000 20:26:33 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:58609 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129091AbQKPB0Z>;
	Wed, 15 Nov 2000 20:26:25 -0500
Date: Thu, 16 Nov 2000 01:56:09 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200011160056.BAA20778@harpo.it.uu.se>
To: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: New bluesmoke patch available, implements MCE-without-MCA support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Nov 2000, H. Peter Anvin wrote:

>This implements support for MCE on chips which don't support MCA (in
>addition to enabling MCA for non-Intel chips, like Athlon, which
>supports MCA.)
>
>I would appreciate it if people who have chips with MCE but no MCA --
>this includes older AMD chips and some Cyrix chips at the very least
>-- would please be so kind and try this out.

I have a K6-III which announces MCE but not MCA, so I was going to
test this on that machine.

However, both the K6-III manual and the K6 BIOS guide state quite
clearly that the K6 family only has a "stub" MCE implementation.
The MCE capability is announced, there are two MCE-related MSRs,
and there is a CR4.MCE flag, but none of it actually _does_ anything.

The new CPU detection code should probably clear FEATURE_MCE for K6 CPUs.
(We might consider it an AMD bug, but in their defense, they do state
that the stub implementation was done for "compatibility" reasons.)

/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
