Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268578AbUIXIXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268578AbUIXIXd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 04:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268581AbUIXIXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 04:23:33 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:64151 "EHLO
	merkurneu.hrz.uni-giessen.de") by vger.kernel.org with ESMTP
	id S268578AbUIXIXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 04:23:30 -0400
Date: Fri, 24 Sep 2004 18:23:10 +1000 (EST)
From: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
X-X-Sender: gc1007@fb07-calculator.math.uni-giessen.de
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lost memory on a 4GB amd64
In-Reply-To: <200409240915.34471.andrew@walrond.org>
Message-Id: <Pine.LNX.4.58.0409241819370.15313@fb07-calculator.math.uni-giessen.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au>
 <Pine.LNX.4.58.0409200815420.3644@fb07-calculator.math.uni-giessen.de>
 <Pine.LNX.4.58.0409202020370.5797@magvis2.maths.usyd.edu.au>
 <200409240915.34471.andrew@walrond.org>
Organization: University of Giessen * Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004, Andrew Walrond (AW) wrote:

AW> On Monday 20 Sep 2004 11:26, Sergei Haller wrote:
AW> >
AW> > fang ~sergei> ./memtest 1000000000
AW> > allocate 1000000000: ok
AW> >
AW> > Message from syslogd@fang at Mon Sep 20 18:03:16 2004 ...
AW> > fang kernel: Oops: 0000 [1] PREEMPT SMP
AW> >
AW> 
AW> Works fine on my 4Gb Tyan thunder K8W machine, even running from an xterm:
AW> andrew@orac ~ $ uname -a
AW> Linux orac.walrond.org 2.6.8.1 #3 SMP Sun Aug 29 17:36:49 BST 2004 x86_64 
AW> unknown unknown GNU/Linux
AW> 
AW> andrew@orac ~ $ free -m
AW>              total       used       free     shared    buffers     cached
AW> Mem:          4008        263       3744          0          0         66
AW> -/+ buffers/cache:        195       3812
AW> Swap:         3827         25       3802
AW> 
AW> andrew@orac ~ $ ./memtest 1000000000
AW> allocate 1000000000: ok
AW> set them to 0... done
AW> andrew@orac ~ $ ./memtest 4000000000
AW> allocate 4000000000: ok
AW> set them to 0... done
AW> andrew@orac ~ $ ./memtest 5000000000
AW> allocate 5000000000: ok
AW> set them to 0... done
AW> andrew@orac ~ $
AW> 
AW> The last one took a while (using 1Gb swap) but it still worked fine.

Hi Andrew,

thanks for your report. 

It's the same for me if I use the non-SMP version of the kernel.
but the SMP one seems to be panicking for some reason.


        Sergei
-- 
--------------------------------------------------------------------  -?)
         eMail:       Sergei.Haller@math.uni-giessen.de               /\\
-------------------------------------------------------------------- _\_V
Be careful of reading health books, you might die of a misprint.
                -- Mark Twain
