Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276424AbRK1Q4x>; Wed, 28 Nov 2001 11:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276344AbRK1Q4e>; Wed, 28 Nov 2001 11:56:34 -0500
Received: from nlaknet.slt.lk ([203.115.0.2]:64502 "EHLO laknet.slt.lk")
	by vger.kernel.org with ESMTP id <S275990AbRK1Q4a>;
	Wed, 28 Nov 2001 11:56:30 -0500
Message-ID: <3C05BEB7.1BA4497B@sltnet.lk>
Date: Wed, 28 Nov 2001 22:51:03 -0600
From: Ishan Oshadi Jayawardena <ioshadi@sltnet.lk>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16-0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: "spurious 8259A interrupt: IRQ7"
In-Reply-To: <E168ipq-00019Y-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> IRQ7 is asserted when the PIC sees an interrupt but nobody appears to be
> generating it when it looks.
> -

	I had the same symptoms on an uniprocessor IBM PC300GL (pretty standard
pc, 32MB ram, 333MHz celeron [pre-coppermine], 82371AB PIIX E-IDE/ACPI
chips,
Intel Motherboard, 66MHz bus), S3 Trio3D (IBM integrated - **does that
mean anything to you? XFree86-SVGA doesn't work on it, but XFree86-S3
version 4.0.1
-RH 7.0- seems to work fine with the s3virge driver) AGP graphics board
(2MB
vram) plus an Avance ALS4000 card are all I've got. I was worried
because
I don't have any 8259A's on my motherboard and this led me to kgcc.
	The problem occured _only_ when I, unknowingly, used RH 7.0's gcc 2.96
(not one of the updated 2.96's). With that build (a 2.4.8 kernel), I
learnt my lesson when linux got utterly stuck twice in a single day.
Since then, builds with standard gcc's recommended by Linus (egcs/kgcc
&& gcc 2.95.3) have seen the end of this problem. The message came up
during normal use, not in a special situation such as bootup, etc.
	Hope this has been of some help.

PS: Is gcc-2.96.99 currently in RawHide as good (or better ;) as
gcc-2.95.3 for kernel builds? Jakub Jelinek seems to be doing a good job
on it...

	- ioj

-----------------------------------------------------------------------
	"And King Parakramabahu sent men with a bushel of Rice each to every
corner of the land, and the people returned saying that a bushel of Rice
could
be sold for two cents. Then the King knew that not enough food or his
people was being produced. He built tanks of water and cultivated more
land. Again deployed men. Now they returned saying that no one would
take the grain even
for free. The King was satisfied."
