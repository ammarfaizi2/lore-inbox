Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130109AbQKVAiq>; Tue, 21 Nov 2000 19:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130417AbQKVAif>; Tue, 21 Nov 2000 19:38:35 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:38923 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130109AbQKVAiY>; Tue, 21 Nov 2000 19:38:24 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux 2.4.0test11-ac1
Date: 21 Nov 2000 16:07:52 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8vf2oo$338$1@cesium.transmeta.com>
In-Reply-To: <Pine.GSO.3.96.1001121195742.28403E-100000@delta.ds2.pg.gda.pl> <E13yMsl-0005Lb-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E13yMsl-0005Lb-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
> 
> > > making any assumptions about APIC availability on a processor.
> > 
> >  OK, but how does it handle the 82489DX?  There are valid configurations
> > using this kind of APIC, including Pentium P54C ones...
> 
> These processors don't report the APIC on the cpuid ? If so then I guess
> the fix is something like this
> 
> 	if( cpuid says there is no local apic && vendor != intel)
> 
> Intel stuff appears to always be happy poking in APIC space. I don't know
> if this is related to the chip internals on the non APIC capable chips.
> 

Nononono... the 82489DX is an *external* APIC, which should be usable
on any Socket 5/7 CPU...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
