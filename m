Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135698AbRBETov>; Mon, 5 Feb 2001 14:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135709AbRBETol>; Mon, 5 Feb 2001 14:44:41 -0500
Received: from smtp7.xs4all.nl ([194.109.127.133]:44250 "EHLO smtp7.xs4all.nl")
	by vger.kernel.org with ESMTP id <S135707AbRBEToi>;
	Mon, 5 Feb 2001 14:44:38 -0500
Date: Mon, 5 Feb 2001 19:41:11 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: Frank de Lange <frank@unternet.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hard crashes 2.4.0/1 with NE2K stuff
Message-ID: <20010205194111.A888@grobbebol.xs4all.nl>
In-Reply-To: <20010202145216.C13831@unternet.org> <20010205182652.B604@grobbebol.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010205182652.B604@grobbebol.xs4all.nl>; from roel@grobbebol.xs4all.nl on Mon, Feb 05, 2001 at 06:26:52PM +0000
X-OS: Linux grobbebol 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2001 at 06:26:52PM +0000, Roeland Th. Jansen wrote:
> 
> I'll report further. an Maciej -- thanks for your work !

with the extra patch in arch/i386/kernel/apic.c:

#else
        /* Disable focus processor (bit==1) */
        value |= (1<<9);
#endif

used, eth0 (ne2k) doesn't die anymore; no choppy sound either. we're
currently having over 2.100.000 interrupts without a problem.

-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
