Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269517AbUIROTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269517AbUIROTp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 10:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269508AbUIROTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 10:19:45 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:25521 "EHLO
	merkurneu.hrz.uni-giessen.de") by vger.kernel.org with ESMTP
	id S269517AbUIROTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 10:19:43 -0400
Date: Sun, 19 Sep 2004 00:18:38 +1000 (EST)
From: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
X-X-Sender: gc1007@fb07-calculator.math.uni-giessen.de
To: Andrew Walrond <andrew@walrond.org>
Subject: Re: lost memory on a 4GB amd64
In-Reply-To: <Pine.LNX.4.58.0409170147320.26494@fb07-calculator.math.uni-giessen.de>
Message-Id: <Pine.LNX.4.58.0409190007530.31971@fb07-calculator.math.uni-giessen.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au>
 <200409161528.19409.andrew@walrond.org>
 <Pine.LNX.4.58.0409170051200.26494@fb07-calculator.math.uni-giessen.de>
 <200409161619.28742.andrew@walrond.org>
 <Pine.LNX.4.58.0409170147320.26494@fb07-calculator.math.uni-giessen.de>
Organization: University of Giessen * Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2004, Sergei Haller (SH) wrote:

SH> AW> No - thats what I use. Do you have MTRR support enabled?
SH> 
SH> yes.
SH> 
SH> AW> I'll send you my .config file; Perhaps you could try that.
SH> 
SH> I just had a look at it. tomorrow morning I'll try out some of the
SH> options. 

I tried out many configurations of the kernel config, nothing helped.

now I switched off SMP and it runs stable! So what am I to do about it?

that's the summary:

* if the memory is configured in one chunk (0-4gb) then the SMP kernel 
  works, but I only have about 3.4 gb main memory. (I know why)

* if the memory configuration is as follows: the first 3gb ar at the 
  normal address range, the fourth gb is at the address range 4-5gb.
  then all 4gb are available (not quite -- a few mb ere missing, but 
  thats ok) and 
   - the SMP kernel panics as soon as I start X or allocate about 1.6gb of
     memory (maybe less would trigger that as well, that was the only test
     I ran) ahh, kernel compillation runs fine.
   - the non-SMP kernel runs stable.
   - memtest86 runs fine

all kernels I mention are 2.6.8.1 vanilla.

What do you think? Is there anything I can do?



        Sergei
-- 
--------------------------------------------------------------------  -?)
         eMail:       Sergei.Haller@math.uni-giessen.de               /\\
-------------------------------------------------------------------- _\_V
Be careful of reading health books, you might die of a misprint.
                -- Mark Twain
