Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315762AbSHAREB>; Thu, 1 Aug 2002 13:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315784AbSHAREA>; Thu, 1 Aug 2002 13:04:00 -0400
Received: from daimi.au.dk ([130.225.16.1]:40602 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S315762AbSHAREA>;
	Thu, 1 Aug 2002 13:04:00 -0400
Message-ID: <3D496A24.4E134ED5@daimi.au.dk>
Date: Thu, 01 Aug 2002 19:04:36 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, root@chaos.analogic.com,
       stas.orel@mailcity.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] vm86: Clear AC on INT
References: <Pine.GSO.3.96.1020801183410.8256M-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" wrote:
> 
> On Thu, 1 Aug 2002, Kasper Dupont wrote:
> 
> > Ehrm, that wasn't my point. My point was that if the feature exist
> > in virtual 86 mode but not in real mode, the kernel should prevent
> > it from being used in virtual 86 mode because it is supposed to
> > emulate real mode.
> 
>  The mode is supposed to emulate an 8086 which doesn't have the flag.

OK, but if it is only supposed to emulate an 8086 shouldn't it have
trapped on every instruction not existing on 8086? It doesn't and
that is quite fortunate, because we can then use it for other purposes
namely runing software that expects to have the entire computer for
itself in a multitasking environment. However it seems no matter how
we do it, what is emulated will not work exactly like any CPU in real
mode.

> Any "real mode" code that operates on the AC flag must have been
> created after i386 was released as it requires 32-bit instructions.  Hence
> it has to be prepared to deal with the vm86 mode.

That does make some sense, but not all software written for i386 and
later processors does deal with vm86 in the desired way. Some software
was only intended for real mode when being written, but we might now
want to run it in virtual 86 mode. Thanks to emm386 we probably don't
see many DOS programs not working in virtual 86 mode, but emm386 itself
plain refuses to load in virtual 86 mode.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razrep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
