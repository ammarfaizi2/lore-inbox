Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129557AbQLBOlV>; Sat, 2 Dec 2000 09:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130077AbQLBOlL>; Sat, 2 Dec 2000 09:41:11 -0500
Received: from 62-6-233-52.btconnect.com ([62.6.233.52]:9476 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129557AbQLBOk7>;
	Sat, 2 Dec 2000 09:40:59 -0500
Date: Sat, 2 Dec 2000 14:11:35 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.0-test12-pre3] microcode update for P4 (fwd)
In-Reply-To: <90a1ca$3rt$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.21.0012021406450.902-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Dec 2000, H. Peter Anvin wrote:
> > +/* symbolic names for some interesting MSRs */
> > +#define IA32_PLATFORM_ID	0x17
> > +#define IA32_UCODE_WRITE	0x79
> > +#define IA32_UCODE_REV		0x8B
> > 
> 
> Please call these MSR_* instead, "IA32_*" isn't very descriptive,
> besides, the preferred prefix in existing locations in the Linux
> kernel is "X86_", e.g. X86_EFLAGS_IF or X86_CR4_PSE.  I think there
> are standard symbolic names for most MSRs in volume 3 of the Intel
> processor manuals; I would suggest we use those.
                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~

which is exactly what I did. The old name for 0x17 was something like
BBL_CR_OVRD which had absolutely no meaning (or no meaning that I could
discern) so in the past I use just the number 0x17. Now (see P4 manuals,
already on developer.intel.com) they renamed to a very meaningful
IA32_PLATFORM_ID so I used that one. It is more important to match the
naming of the original specs than to be consistent with other naming used
in the kernel. To prove this point I suggest you look at NFSv2/NFSv3
naming used in the Linux kernel -- it matches rfc1094/rfc1813 which I
liked very much because it simplified reading kernel code (I assume
everyone first studies the specs and then reads Linux implementation).

Now that was about 0x17. As for 0x79 and 0x8B I made up my own names using
the Intel's one for 0x17 as a guideline. So they "look just like" as if
they were from the manual too ;) (and they are meaningful, which is a
bonus)

I am also glad Alan agrees with me.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
