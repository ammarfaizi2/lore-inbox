Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315463AbSHAPw2>; Thu, 1 Aug 2002 11:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315529AbSHAPw2>; Thu, 1 Aug 2002 11:52:28 -0400
Received: from daimi.au.dk ([130.225.16.1]:17298 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S315463AbSHAPw1>;
	Thu, 1 Aug 2002 11:52:27 -0400
Message-ID: <3D4959EF.15022EE8@daimi.au.dk>
Date: Thu, 01 Aug 2002 17:55:27 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: root@chaos.analogic.com, stas.orel@mailcity.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] vm86: Clear AC on INT
References: <Pine.LNX.3.95.1020801105021.26692A-100000@chaos.analogic.com> <1028220750.15022.67.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Thu, 2002-08-01 at 16:15, Richard B. Johnson wrote:
> > Alignment-check does not exist in real mode. Therefore AC flags
> > mean nothing. In fact, you can't even access more than 16 bits
> > of the flags register in real mode, even by playing tricks
> > (pushf pushes only 16 bits, even if you prefix it with 0x66).
> 
> The kernel using virtual 8086 mode, not real mode. In Virtual 8086 mode
> the alignment trap is enforced and honoured.

Sure, but I guess the kernel is supposed to use virtual 86 mode
to emulate real mode. If it really is true that AC is honoured
in virtual 86 mode but ignored in real mode, then the kernel
should be changed to not enable that flag en virtual 86 mode.
The flag itself should still be simulated using other means.

This would be similar to the use of the use of the VIF flag to
emulate the IF flag. This flag has actually got me wondering:
AFAIR the flag is mentioned in Intel specs, but it looks like
in Linux the flag is implemented 100% in software with no help
from the CPU. Is that correct, or did I miss something?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razrep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
