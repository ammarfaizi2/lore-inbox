Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVFBCRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVFBCRs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 22:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVFBCRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 22:17:48 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:61834 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261566AbVFBCRr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 22:17:47 -0400
X-ORBL: [69.107.40.98]
From: David Brownell <david-b@pacbell.net>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Subject: Re: External USB2 HDD affects speed hda
Date: Wed, 1 Jun 2005 19:17:14 -0700
User-Agent: KMail/1.7.1
Cc: Rene Herman <rene.herman@keyaccess.nl>, Pavel Machek <pavel@ucw.cz>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Mark Lord <lkml@rtr.ca>,
       David Brownell <dbrownell@users.sourceforge.net>
References: <429BA001.2030405@keyaccess.nl> <200506011643.42073.david-b@pacbell.net> <Pine.LNX.4.58.0506020316240.28167@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.58.0506020316240.28167@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506011917.14678.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 June 2005 6:23 pm, Mikulas Patocka wrote:
> 
> Didn't you just forget to set H-bit in exactly one queue head? If there's
> no entry with H-bit set, controller will loop over list of empty heads
> again and again.

Two things:

 - Why do you ask that?  There's only one QH that _ever_ has that bit set.
   And it's never removed from the async ring.

 - The question should be why the schedule is getting turned on in the
   first place, given there's no work for it to do.

Until I have some time available to actually look at this, all I can do
is answer questions and say "hmm, that's strange" given wierd facts.  The
wierdness here is why that "Async" status bit is ever getting set when
there's no work for it to do.

- Dave
 
