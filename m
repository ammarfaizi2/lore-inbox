Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265791AbUFINS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265791AbUFINS4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 09:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265772AbUFINRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 09:17:22 -0400
Received: from cantor.suse.de ([195.135.220.2]:5824 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265791AbUFINQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 09:16:36 -0400
Date: Wed, 9 Jun 2004 15:16:28 +0200
From: Karsten Keil <kkeil@suse.de>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de,
       linux-kernel@vger.kernel.org
Subject: Re: [STACK] weird code in some isdn drivers
Message-ID: <20040609131628.GA10403@pingi3.kke.suse.de>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de,
	linux-kernel@vger.kernel.org
References: <20040609123633.GH21168@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040609123633.GH21168@wohnheim.fh-wedel.de>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.4-52-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 02:36:33PM +0200, Jörn Engel wrote:
> Karsten, Kai,
> 
> while I agree that this is a measurement bug, it's not exacly fun to
> look at the code in question.  Can you please find a solution for
> hscx_irq.c?

HiSax and I4L is in bugfix only mode, since it will replaced
by other drivers. So I do not want waste time for soon obsolate code.

> 
> Either transform it into a header and uninline some of the longer
> functions or make the functions global and add the necessary header
> and Makefile-line.  In any case, I don't like to see something like
> #include "hscx_irq.c"
> 

Yes I agree that it looks ugly and make not much more sense with today
CPUs and compilers. In the beginning of the development (on 386/486) and
with early GCC (inline was often broken) it did and reduced some
ping times so far I remember. (~1997)

> stackframes for call path too long (268435490):
>     size  function
>        0  IsdnCardState->irq_func
> 268435466  teles3_interrupt
>       24  hscx_empty_fifo
>        0  read_fifo
>        0  insb
> 
> Jörn
> 
> -- 
> People will accept your ideas much more readily if you tell them
> that Benjamin Franklin said it first.
> -- unknown

-- 
Karsten Keil
SuSE Labs
ISDN development
