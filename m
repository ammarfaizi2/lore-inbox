Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291065AbSBGBzh>; Wed, 6 Feb 2002 20:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291066AbSBGBz2>; Wed, 6 Feb 2002 20:55:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31248 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291065AbSBGBzQ>; Wed, 6 Feb 2002 20:55:16 -0500
Subject: Re: want opinions on possible glitch in 2.4 network error reporting
To: ionut@cs.columbia.edu (Ion Badulescu)
Date: Thu, 7 Feb 2002 02:08:10 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        cfriesen@nortelnetworks.com (Chris Friesen)
In-Reply-To: <200202070151.g171p4h11574@moisil.badula.org> from "Ion Badulescu" at Feb 06, 2002 08:51:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Ydys-0007D6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > That is correct UDP behaviour
> 
> This is totally untrue, unless the socket doing non-blocking I/O -- and
> even then you get -1 and EAGAIN from sendto.

Not the case.

> there is no way to "lose" that data before it hits the wire, unless of
> course the network driver is broken and doesn't plug the upper layers when
> its TX queue is full.

UDP is not flow controlled.

> Think of it: if what you said were true, NFS over UDP would be totally
> useless. But it's not, so if UDP data gets lost before it hits the wire,
> it's usually a bug in the network driver.

NFS does UDP flow control of its own. If it didnt it would indeed be
broken.
