Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVCZIbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVCZIbN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 03:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVCZIbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 03:31:13 -0500
Received: from grunt14.ihug.co.nz ([203.109.254.61]:32655 "EHLO
	grunt14.ihug.co.nz") by vger.kernel.org with ESMTP id S261772AbVCZIbB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 03:31:01 -0500
Date: Sat, 26 Mar 2005 20:18:04 +1200 (NZST)
From: Bart Oldeman <bartoldeman@users.sourceforge.net>
X-X-Sender: enbeo@enm-bo-lt.localnet
To: Arjan van de Ven <arjan@infradead.org>
cc: Arnd Bergmann <arnd@arndb.de>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, linux-msdos@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.12-rc1 breaks dosemu
In-Reply-To: <1111824629.6293.19.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0503262009040.3040@enm-bo-lt.localnet>
References: <20050320021141.GA4449@stusta.de>  <200503251952.33558.arnd@arndb.de>
  <1111778074.6312.87.camel@laptopd505.fenrus.org>  <200503252354.53154.arnd@arndb.de>
 <1111824629.6293.19.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Mar 2005, Arjan van de Ven wrote:

> On Fri, 2005-03-25 at 23:54 +0100, Arnd Bergmann wrote:
> > On Freedag 25 März 2005 20:14, Arjan van de Ven wrote:
> >
> > > the randomisation patches came in a series of 8 patches (where several
> > > were general infrastructure); could you try to disable the individual
> > > randomisations one at a time to see which one causes this effect?
> >
> > It's caused by top-of-stack-randomization.patch.
>
> > eip: 0x000069ee  esp: 0xbfdbffcc  eflags: 0x00010246
>
> hmm interesting. Can you check if at the time of the crash, the esp is
> actually inside the stack vma? If it's not, I wonder what dosemu does to
> get its stack pointer outside the vma... (and on which side of the vma
> it is)

To Arnd:

Another thing you should probably do is to build dosemu with debug
information, and then look into ~/.dosemu/boot.log after it crashes.
That will give you the contents of /proc/self/maps, a gdb backtrace and
various other goodies.

I've checked it myself but can't reproduce, neither with plain dosemu
1.2.2 nor with current CVS.

Bart
