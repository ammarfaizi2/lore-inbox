Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274734AbRIYXnA>; Tue, 25 Sep 2001 19:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274732AbRIYXmv>; Tue, 25 Sep 2001 19:42:51 -0400
Received: from CPE-61-9-148-139.vic.bigpond.net.au ([61.9.148.139]:47343 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S274727AbRIYXmi>; Tue, 25 Sep 2001 19:42:38 -0400
Message-ID: <3BB115AC.9D1A8EC8@eyal.emu.id.au>
Date: Wed, 26 Sep 2001 09:39:24 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-pre15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: question from linuxppc group
In-Reply-To: <3BB0E2F2.CD668D18@wvi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Potter wrote:
> 
> We have  a host bridge (plus PIC, mem ctlr, etc.) that is essentially
> identical
> for ppc and mips.  Where is the best place to put the code since we
> don't want to
> duplicate it for both architectures?

A common practice is to create a pseudo-arch directory, let's called
it 'shared' or 'common' and under it a directory for each component
that is shared. We can now have symbolic links for s shared file:
	arch/[mips|ppc]/pic.c -> arch/shared/pic-mippc.c

Or, for a shared subsystem 'pic1234'
	arch/[mips|ppc]/pic -> arch/shared/pic-mippc

One can even look at more similar archs and have
	arch/[mips|ppc]/pic -> arch/shared/mippc/pic
	arch/[mips|ppc]/mem -> arch/shared/mippc/mem

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
