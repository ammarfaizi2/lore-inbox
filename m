Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316542AbSHARpn>; Thu, 1 Aug 2002 13:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316544AbSHARpn>; Thu, 1 Aug 2002 13:45:43 -0400
Received: from daimi.au.dk ([130.225.16.1]:29087 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S316542AbSHARph>;
	Thu, 1 Aug 2002 13:45:37 -0400
Message-ID: <3D497477.167D6D1F@daimi.au.dk>
Date: Thu, 01 Aug 2002 19:48:39 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, stas.orel@mailcity.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] vm86: Clear AC on INT
References: <Pine.LNX.3.95.1020801132809.27785B-100000@chaos.analogic.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Thu, 1 Aug 2002, Kasper Dupont wrote:
> [SNIPPED...]
> 
> > want to run it in virtual 86 mode. Thanks to emm386 we probably don't
> > see many DOS programs not working in virtual 86 mode, but emm386 itself
> > plain refuses to load in virtual 86 mode.
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> But of course! It's a 32-bit 'trap program', they runs your whole
> computer in VM86 mode, paging in memory from above 1 megabyte to
> some 'window' below 1 megabyte.
> 
> Any attempt to load it cause a trap to Linux when the PE bit is
> attempted to be set.
> 
> You don't need emm386 because Linux emulates its functionality.

Sure, if you just want to run DOS and DOS programs you could do
better than using emm386. But if you are actually tring to
emulate a PC, it should have been able to load emm386 without
emm386 even noticing the difference. I guess this just proves
that vm86 isn't well suited for a complete emulation.

IMHO nowadays a reasonable requirement for a good architecture
is that it can easily emulate itself. I guess from that point of
view x86 is not a good architecture, but that shouldn't stop us
from trying to get as close as possible.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razrep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
