Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136424AbRAZSeE>; Fri, 26 Jan 2001 13:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136441AbRAZSdy>; Fri, 26 Jan 2001 13:33:54 -0500
Received: from quechua.inka.de ([212.227.14.2]:11050 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S136424AbRAZSdu>;
	Fri, 26 Jan 2001 13:33:50 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <14961.25754.449497.640325@pizda.ninka.net> <Pine.SOL.4.21.0101261351150.11126-100000@red.csi.cam.ac.uk> <20010126151138.B6331@pcep-jamie.cern.ch>
Organization: private Linux site, southern Germany
Date: Fri, 26 Jan 2001 19:19:23 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E14MDT5-0001Am-00@g212.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I was not suggesting ignoring these. OTOH, there is no reason to treat an
> > RST packet as "go away and never ever send traffic to this host again" -
> > i.e. trying another TCP connection, this time with ECN disabled, would be
> > acceptable.
> 
> Using a different source port number, even.

But that has to be done on the application level, which means we need a
socket option to not use ECN. It is not acceptable that the kernel changes
the port number of a socket which already has one, or any application which
uses getsockname() on the connecting socket will horribly break.[1]

Olaf

[1] and this means any application using libsocks5, so nobody tell me "no
sane application does need this".
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
