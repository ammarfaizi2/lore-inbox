Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135971AbRDTQlH>; Fri, 20 Apr 2001 12:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135966AbRDTQk6>; Fri, 20 Apr 2001 12:40:58 -0400
Received: from coruscant.franken.de ([193.174.159.226]:46864 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S135967AbRDTQkn>; Fri, 20 Apr 2001 12:40:43 -0400
Date: Fri, 20 Apr 2001 13:21:38 -0300
From: Harald Welte <laforge@gnumonks.org>
To: Olaf Titz <olaf@bigred.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Counters [Re: IP Acounting Idea for 2.5]
Message-ID: <20010420132138.B2461@tatooine.laforge.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33.0104152039130.1616-100000@asdf.capslock.lan> <01041708461209.00352@workshop> <20010416020732.30431.qmail@logi.cc> <20010416104310.A29075@flint.arm.linux.org.uk> <E14pSji-0000Ng-00@hunte.bigred.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <E14pSji-0000Ng-00@hunte.bigred.inka.de>; from olaf@bigred.inka.de on Tue, Apr 17, 2001 at 12:29:30PM +0200
X-Operating-System: Linux tatooine.laforge.distro.conectiva 2.4.2-ac20
X-Date: Today is Setting Orange, the 37th day of Discord in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2001 at 12:29:30PM +0200, Olaf Titz wrote:
> > Umm, no.  Counters can be resetable - you just specify that accounting
> > programs should not reset them, ever.
> >
> > The ability to reset counters is extremely useful if you're a human
> > looking at the output of iptables -L -v.  (I thus far know of no one
> > who can memorise the counter values for around 40 rules).
> 
> You'll get bogus accounting results unless you stop/restart the
> accounting programs every time you manually deal with the counters.
> This sounds dangerously easy to make mistakes to me.

mmh. But isn't that obvious? Every time you mess with anything (counters
or rules) of the chains/tables, your accounting program will get into
trouble, if it relies on those counters.

I don't think that it makes sense to do iptables-based accounting if you have
changes to the ruleset (counters and/or rules) at runtime. You'd have 
to be very cautious what you are doing.

> Olaf

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org                http://www.gnumonks.org
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
