Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269796AbRH3JTl>; Thu, 30 Aug 2001 05:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271741AbRH3JTb>; Thu, 30 Aug 2001 05:19:31 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:56569 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S269796AbRH3JTU>; Thu, 30 Aug 2001 05:19:20 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Thu, 30 Aug 2001 03:19:18 -0600
To: Terje Eggestad <terje.eggestad@scali.no>
Cc: Elan Feingold <efeingold@mn.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: Multithreaded core dumps (CLONE_THREAD and elf)
Message-ID: <20010830031918.H541@turbolinux.com>
Mail-Followup-To: Terje Eggestad <terje.eggestad@scali.no>,
	Elan Feingold <efeingold@mn.rr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <000c01c13113$91d7c060$0400000a@gorilla> <999159394.23678.285.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <999159394.23678.285.camel@pc-16.office.scali.no>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 30, 2001  10:16 +0200, Terje Eggestad wrote:
> THere is a CLONE_THREAD flag to clone() that sets up a linked list thru
> all the procs (shared VM or not) that in 2.4.3 that I currently run
> don't seem to be ready for general use, managed to get this:
> te       31504 31504  0 10:03 pts/0    00:00:00 [clone2 <defunct>]
> te       31505 31504  0 10:03 pts/0    00:00:00 [clone2 <defunct>]
> 
> Where a zombie is waiting for the parent to receive it's SIGCHLD, but
> it's its own parent. Kinda cute, guess Its time to reboot....

I'm pretty sure Linus had a patch for this in 2.4.7 or so, which
reparented the thread to init, so it would be reaped on exit.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

