Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313419AbSG2IfA>; Mon, 29 Jul 2002 04:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313421AbSG2IfA>; Mon, 29 Jul 2002 04:35:00 -0400
Received: from [196.26.86.1] ([196.26.86.1]:47809 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S313419AbSG2Ie7>; Mon, 29 Jul 2002 04:34:59 -0400
Date: Mon, 29 Jul 2002 10:56:01 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Muli Ben-Yehuda <mulix@actcom.co.il>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.29 sound/oss/trident.c [2/2] remove cli/sti calls
In-Reply-To: <20020729080836.GO10499@alhambra.actcom.co.il>
Message-ID: <Pine.LNX.4.44.0207291047570.20701-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2002, Muli Ben-Yehuda wrote:

> On Mon, Jul 29, 2002 at 10:08:52AM +0200, Zwane Mwaikambo wrote:
> > On Sun, 28 Jul 2002, Muli Ben-Yehuda wrote:
> > 
> > > +
> > > +	spin_unlock_irqrestore(&card->lock, flags); 
> > >  	
> > >  	restore_flags(flags);
> > >  }
> > 
> > hmm...
> 
> grrr, harmless I think, but thanks for spotting it. 

But still racy, i think i may try a test run with some code to poison 
flags after its already been used to xxx_restore.

Cheers,
	Zwane

-- 
function.linuxpower.ca


