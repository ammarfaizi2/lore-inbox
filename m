Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267597AbUIXEiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267597AbUIXEiv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 00:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267679AbUIXEiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 00:38:51 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:29175 "EHLO
	merkurneu.hrz.uni-giessen.de") by vger.kernel.org with ESMTP
	id S267597AbUIXEir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 00:38:47 -0400
Date: Fri, 24 Sep 2004 14:38:27 +1000 (EST)
From: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
X-X-Sender: gc1007@fb07-calculator.math.uni-giessen.de
To: jonathan@jonmasters.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-smp <linux-smp@vger.rutgers.edu>
Subject: Re: lost memory on a 4GB amd64
In-Reply-To: <Pine.LNX.4.58.0409202020370.5797@magvis2.maths.usyd.edu.au>
Message-Id: <Pine.LNX.4.58.0409241422050.15313@fb07-calculator.math.uni-giessen.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au> 
 <200409161528.19409.andrew@walrond.org> 
 <Pine.LNX.4.58.0409170051200.26494@fb07-calculator.math.uni-giessen.de> 
 <200409161619.28742.andrew@walrond.org> 
 <Pine.LNX.4.58.0409170147320.26494@fb07-calculator.math.uni-giessen.de> 
 <Pine.LNX.4.58.0409190007530.31971@fb07-calculator.math.uni-giessen.de> 
 <35fb2e59040919130154966337@mail.gmail.com> 
 <Pine.LNX.4.58.0409200737010.3644@fb07-calculator.math.uni-giessen.de>
 <35fb2e5904091915007c02c4b8@mail.gmail.com>
 <Pine.LNX.4.58.0409200815420.3644@fb07-calculator.math.uni-giessen.de>
 <Pine.LNX.4.58.0409202020370.5797@magvis2.maths.usyd.edu.au>
Organization: University of Giessen * Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.58.0409241422052.15313@fb07-calculator.math.uni-giessen.de>
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just discovered the linux-smp list and decided to summarize the topic 
and take the opportunity to cross-post to there.

an archive of the discussion can be found e.g. here:
http://marc.theaimsgroup.com/?t=109525952600004&r=1&w=4


The machine at hand is the Tyan Tiger K8W with two Opterons 246
(http://www.tyan.com/products/html/tigerk8w.html) and 4GB of memory

we are using vanilla 2.6.8.1 kernel.

 * if the memory is set up in the ordinary way in the BIOS, then
   approximately 512MB are lost (PCI/AGM adressing and stuff), but
   everything is stable
 * if the memory is set up in the BIOS to be in two chunks (e.g. 3GB at 
   the address range 0-3GB and 1GB at 4-5GB address range), then
    - memtest86 tells everything is fine.
    - if we run a non-SMP kernel, everything is stable
    - if we run an SMP kernel, it crashes as soon as approx. 1GB of memory
      is allocated and set to 0 (see the test case C-program in my
      previous mail)

Is there anything we can do? Any logs I can provide? Something to try out?

Thanks,
        Sergei
-- 
--------------------------------------------------------------------  -?)
         eMail:       Sergei.Haller@math.uni-giessen.de               /\\
-------------------------------------------------------------------- _\_V
Be careful of reading health books, you might die of a misprint.
                -- Mark Twain
