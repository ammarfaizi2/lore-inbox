Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266868AbUFYVhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266868AbUFYVhY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 17:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266870AbUFYVhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 17:37:24 -0400
Received: from gprs214-91.eurotel.cz ([160.218.214.91]:53632 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266868AbUFYVhG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 17:37:06 -0400
Date: Fri, 25 Jun 2004 23:36:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Amit Gud <gud@eth.net>
Cc: Alan <alan@clueserver.org>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       "Fao, Sean" <Sean.Fao@dynextechnologies.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Elastic Quota File System (EQFS)
Message-ID: <20040625213647.GA5907@elf.ucw.cz>
References: <004e01c45abd$35f8c0b0$b18309ca@home> <200406251444.i5PEiYpq008174@eeyore.valparaiso.cl> <20040625162537.GA6201@elf.ucw.cz> <1088181893.6558.12.camel@zontar.fnordora.org> <40DC625F.3010403@eth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40DC625F.3010403@eth.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >This sounds like a hack to get around a badly designed system with too
> I do believe that this system can be done in userspace, but it has its 
> own flaws then. Suppose theres a daemon, call it eqfsd. It forks parent 
> listens a char device, child watches the disk space usage. A kernel 
> module reports the file deletes, chowns to the char device, parent does 
> the needfull. Child 'periodically' checks that the threshold is not 
> reached. Here what can be done is suppose a user can transfer data with  
> say 5 Mbps speed to his account....then we can easily get the
> minimum 

I believe I can write data at 1GB/sec at common hardware (~RAM
speed). You'll either need a *lot* of free space, or very fast
polling, and it will still break when the daemon is swapped out, when
scheduler decides writer is more important etc.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
