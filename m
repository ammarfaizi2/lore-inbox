Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315709AbSHAQhY>; Thu, 1 Aug 2002 12:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315721AbSHAQhX>; Thu, 1 Aug 2002 12:37:23 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:2434 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S315709AbSHAQhV>; Thu, 1 Aug 2002 12:37:21 -0400
Date: Thu, 1 Aug 2002 18:40:31 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Kasper Dupont <kasperd@daimi.au.dk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, root@chaos.analogic.com,
       stas.orel@mailcity.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] vm86: Clear AC on INT
In-Reply-To: <3D496019.88237C6@daimi.au.dk>
Message-ID: <Pine.GSO.3.96.1020801183410.8256M-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Aug 2002, Kasper Dupont wrote:

> Ehrm, that wasn't my point. My point was that if the feature exist
> in virtual 86 mode but not in real mode, the kernel should prevent
> it from being used in virtual 86 mode because it is supposed to
> emulate real mode.

 The mode is supposed to emulate an 8086 which doesn't have the flag. 
Everything else that is available in the mode is a pure implementation
property -- disabling the logic involved is simply not justified by any
means.  Any "real mode" code that operates on the AC flag must have been
created after i386 was released as it requires 32-bit instructions.  Hence
it has to be prepared to deal with the vm86 mode. 

 The AC flag doesn't work unless the AM flag is set in cr0 anyway, so
full real mode compatibility may be implemented in software here if
desired. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

