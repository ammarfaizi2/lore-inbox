Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131488AbQKJW0Y>; Fri, 10 Nov 2000 17:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131980AbQKJW0O>; Fri, 10 Nov 2000 17:26:14 -0500
Received: from 13dyn58.delft.casema.net ([212.64.76.58]:31501 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S131627AbQKJW0A>; Fri, 10 Nov 2000 17:26:00 -0500
Message-Id: <200011102225.XAA04339@cave.bitwizard.nl>
Subject: Re: APIC errors w/ 2.4.0-test11-pre2
In-Reply-To: <8uhpuj$1uf$1@cesium.transmeta.com> from "H. Peter Anvin" at "Nov
 10, 2000 01:39:31 pm"
To: "H. Peter Anvin" <hpa@zytor.com>
Date: Fri, 10 Nov 2000 23:25:57 +0100 (MET)
CC: linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Followup to:  <Pine.LNX.4.21.0011101523170.14596-100000@bochum.redhat.de>
> By author:    Bernhard Rosenkraenzer <bero@redhat.de>
> In newsgroup: linux.dev.kernel
> >
> > Hi,
> > after booting a 2.4.0 (any testx-release I've tried so far, including
> > test11-pre2) on a Dual-Pentium III box, the system works ok, but the
> > console gets filled with
> > 
> > APIC error on CPU0: 08(08)
> > 
> > every couple of seconds, occasionally some lines in between say
> > 
> > APIC error on CPU0: 08(02)
> > 
> > and
> > 
> > APIC error on CPU0: 02(08)
> > 
 
> I have seen the same problem on the same motherboard.  It appears to
> be a motherboard bug that 2.4 exposes and 2.2 doesn't.

This PRINT was added in 2.4. 

You're seeing noise on the apic lines. The APICs notice, but every now
and then you may see a lockup due to this. (i.e. if the corruption
does not trigger a parity error, because two bits flipped!)

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
*       Common sense is the collection of                                *
******  prejudices acquired by age eighteen.   -- Albert Einstein ********
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
