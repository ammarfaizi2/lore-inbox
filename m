Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbUB1OpZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 09:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUB1OpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 09:45:25 -0500
Received: from slimnet.xs4all.nl ([194.109.194.192]:57784 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S261853AbUB1OpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 09:45:13 -0500
Subject: Re: Where does this load come from?
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200402281504.41993.vda@port.imtp.ilyichevsk.odessa.ua>
References: <1077971267.10257.24.camel@paragon.slim>
	 <200402281504.41993.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Message-Id: <1077979732.5980.3.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 28 Feb 2004 15:48:52 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-02-28 at 14:04, Denis Vlasenko wrote: 
> On Saturday 28 February 2004 14:27, Jurgen Kramer wrote:
> > Hi,
> >
> > I am seeing some strange load figures on my P4 Celeron based system
> > which I cannot explain. There always seem to be some load while there
> > are no real apps running. Stopping all daemons doesn't seem to effect
> > things at all.
> >
> > Output from top with 2.6.4-rc1:
> >
> >  13:16:38  up 38 min,  1 user,  load average: 1.67, 1.74, 1.57
> > 62 processes: 59 sleeping, 3 running, 0 zombie, 0 stopped
> > CPU states:  47.5% user  52.4% system   0.0% nice   0.0% iowait   0.0%
> > idle
> > Mem:   515552k av,   93544k used,  422008k free,       0k shrd,   10980k
> > buff
> >         49632k active,              29284k inactive
> > Swap:  265064k av,       0k used,  265064k free                   59836k
> > cached
> 
> Post unabridged 'top b n 1' please.
> Top version?
> --
> vda

OK I found the culprit. Some script got started in rc.local which took
all the CPU time :-( (although it's a very simple script...).

Sorry that I bothered you with this...

Jurgen



