Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267414AbTBLSvY>; Wed, 12 Feb 2003 13:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267415AbTBLSvY>; Wed, 12 Feb 2003 13:51:24 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32528 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267414AbTBLSvO>; Wed, 12 Feb 2003 13:51:14 -0500
Date: Wed, 12 Feb 2003 10:57:40 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <jamie@shareable.org>
cc: mika.penttila@kolumbus.fi, <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Dave Jones <davej@codemonkey.org.uk>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Re: [Bug 350] New: i386 context switch very slow compared to
 2.4 due to wrmsr (performance)
In-Reply-To: <20030212182305.GA12039@bjl1.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0302121056220.8062-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mika.penttila@kolumbus.fi wrote:
> BTW, why is sysenter supposed to be disabled while in vm86? 

The only reason is to make vm86-mode more "compatible". In other words, 
trap the GP that happens if SYSENTER_CS is 0, and make sure vm86 mode 
works the way it historically did.

We can choose to say "screw it", I guess, and just see if it actually 
breaks anything.

		Linus

