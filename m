Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272855AbTHPLqL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 07:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272858AbTHPLqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 07:46:11 -0400
Received: from mail.suse.de ([213.95.15.193]:2833 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S272855AbTHPLqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 07:46:08 -0400
Date: Sat, 16 Aug 2003 13:44:10 +0200
From: Karsten Keil <kkeil@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Adrian Bunk <bunk@fs.tum.de>, isdn4linux@listserv.isdn4linux.de,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] ISDN PCBIT: #ifdef MODULE some code
Message-ID: <20030816114410.GA15437@pingi3.kke.suse.de>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Adrian Bunk <bunk@fs.tum.de>, isdn4linux@listserv.isdn4linux.de,
	linux-kernel@vger.kernel.org
References: <20030728202500.GM25402@fs.tum.de> <20030815184720.B0E502CE86@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815184720.B0E502CE86@lists.samba.org>
User-Agent: Mutt/1.4i
Organization: SuSE Linux AG
X-Operating-System: Linux 2.4.21-0-default i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 02:51:20AM +1000, Rusty Russell wrote:
> In message <20030728202500.GM25402@fs.tum.de> you write:
> > I got the following error at the final linkage of 2.6.0-test2 if 
> > CONFIG_ISDN_DRV_PCBIT is compiled statically:
> > 
> > <--  snip  -->
> > 
> > ...
> >   LD      .tmp_vmlinux1
> > ...
> > drivers/built-in.o(.exit.text+0xe183): In function `pcbit_exit':
> > : undefined reference to `pcbit_terminate'
> > make: *** [.tmp_vmlinux1] Error 1
> 
> AFAICT This is also broken in 2.4.22-rc2, which makes me wonder if
> anyone actually cares about this driver?
> 
> Taken anyway, for both.

It is used, I got some reports last year (but this card is only sold in
Portugal and is expensiv so far I know and so not so much people
using this card and linux).

Here 2 reasons why such thinks don't matter today:
1. 99% compile the ISDN stuff as module (and some parts are only work as
   modules)
2. In 2.4 the exit function is removed at compile time, if not compiled as
   modul.

I preparing lot of bugfixes for ISDN and 2.6, but testing needs much time and
many things are broken not only at compile time.

-- 
Karsten Keil
SuSE Labs
ISDN development
