Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263400AbTJZSwC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 13:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263401AbTJZSwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 13:52:02 -0500
Received: from [62.38.242.140] ([62.38.242.140]:61577 "EHLO pfn1.pefnos")
	by vger.kernel.org with ESMTP id S263400AbTJZSwA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 13:52:00 -0500
From: "P. Christeas" <p_christ@hol.gr>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0-test9
Date: Sun, 26 Oct 2003 21:51:32 +0300
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>, Andries.Brouwer@cwi.nl
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200310262051.32801.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Andries.Brouwer:
> Three things:
> 
> 2.6.0t9 still can leave the user with a dead keyboard
> If Vojtech does not provide a better patch I suppose
> you should apply my patch of a few days ago.
> 
> Within a few days two people have reported that they cannot
> mount a FAT fs that 2.4 and Windows handle fine.
> Probably also that should be fixed, for example with
> my patch from yesterday.

One more, (as reported a few weeks ago):
rmmod aic7xxx 
will fail, as this module uses some wrong locks. This will also block sleeping 
(tested w. ACPI) if the module is there.
IMHO this module is crucial to many systems.

I'm just repeating this issue, as I cannot see any patch for that. Justin has 
not replied (I will need to be CC'ed). Andrew, who's the maintainer? I wish I 
could help myself solve that, but fixing SMP-safe locks seems the hardest 
thing I could do here. Somebody has to help here.


