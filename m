Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261791AbSIPLyP>; Mon, 16 Sep 2002 07:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261806AbSIPLyP>; Mon, 16 Sep 2002 07:54:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.18.111]:27666 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261791AbSIPLyO>; Mon, 16 Sep 2002 07:54:14 -0400
Date: Mon, 16 Sep 2002 13:59:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jonathan Buzzard <jonathan@buzzard.org.uk>
Cc: James Blackwell <jblack@linuxguru.net>, linux-kernel@vger.kernel.org,
       hch@infradead.org
Subject: Re: [PATCH] IRQ patch for Toshiba Char Driver in 2.5.34
Message-ID: <20020916115902.GD27545@atrey.karlin.mff.cuni.cz>
References: <20020909115956.GA23290@comet> <20020911112938.A25726@infradead.org> <20020915154248.GA3647@elf.ucw.cz> <20020915213009.A53847@ucw.cz> <20020915195328.GA60517@comet> <20020915200202.GA15744@atrey.karlin.mff.cuni.cz> <E17qiyn-0001ZK-00@jelly.buzzard.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17qiyn-0001ZK-00@jelly.buzzard.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It would be nice to make it preempt/smp safe, through. [SMP notebooks
> > are not so unreasonable; think p4 hyperthreading]. 
> 
> They are here. The code that is protected by cli() and friends does not
> run on any anything more fancy than a Pentium. As I recall nothing but
> mobile P90 in a Portage 610CT and a mobile P120 in a Tecra 700CDT/CDS.

Its still not safe due to preempt.

Anyway #ifdef PREEMPT bug, and comment that this is never ever used on
SMP might be enough.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
