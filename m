Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316695AbSGHBDy>; Sun, 7 Jul 2002 21:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316705AbSGHBDx>; Sun, 7 Jul 2002 21:03:53 -0400
Received: from port17.cvx2-mal.ppp.netlink.se ([62.66.13.18]:20718 "EHLO
	tix.pir.eli") by vger.kernel.org with ESMTP id <S316695AbSGHBDw>;
	Sun, 7 Jul 2002 21:03:52 -0400
Date: Mon, 8 Jul 2002 03:09:26 +0200
From: Daniel Mose <imcol@unicyclist.com>
To: linux-kernel@vger.kernel.org
Cc: lixmeta@unicyclist.com
Subject: Re: simple handling of module removals Re: [OKS] Module removal
Message-ID: <20020708030532.A8799@unicyclist.com>
References: <20020705134816.GA112@elf.ucw.cz> <9171.1026053813@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <9171.1026053813@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> On Fri, 5 Jul 2002 15:48:17 +0200, 
> Pavel Machek <pavel@ucw.cz> wrote:
> >Keith Owens wrote
> >> Modules can run their own kernel threads.  When the module shuts down
> >> it terminates the threads but we must wait until the process entries
> >> for the threads have been reaped.  If you are not careful, the zombie
> >> clean up code can refer to the module that no longer exists.  You must
> >> not freeze any threads that belong to the module.

I am just out to share a possible angle. -all though not really a programmer.

Can one module replace another -running- twin-module without having to hand-
shake with the kernel? -and without freezing ? (transparently)

If obvious no - no need to read further.
 
Otherwhise, there might be a possibility to create a shut-down module out of 
the existing module it self?
In this case it could probably be a smooth solution to ask the module creator.
(if known, and available) if he/she would be able to make this modification 
on the fly, as he/she probably knows the most about how the signals operate. 
That is to strip down the existing loadable module into sort of a dummy. 
Of course this won't work if hazardous removal issues are shared among all or 
most of the existing kernel modules.

An apology for taking up time and bandwith. But rmmod is such a neat command 
to have a round.

/Daniel Mose


    





