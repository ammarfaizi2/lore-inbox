Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268089AbUIPOM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268089AbUIPOM7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 10:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268086AbUIPOMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 10:12:20 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:33730 "EHLO
	merkurneu.hrz.uni-giessen.de") by vger.kernel.org with ESMTP
	id S268083AbUIPOJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 10:09:57 -0400
Date: Fri, 17 Sep 2004 00:09:51 +1000 (EST)
From: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
X-X-Sender: gc1007@fb07-calculator.math.uni-giessen.de
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lost memory on a 4GB amd64
In-Reply-To: <200409161448.39033.andrew@walrond.org>
Message-Id: <Pine.LNX.4.58.0409162358570.26494@fb07-calculator.math.uni-giessen.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au>
 <200409161448.39033.andrew@walrond.org>
Organization: University of Giessen * Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004, Andrew Walrond (AW) wrote:

AW> On Thursday 16 Sep 2004 05:48, Sergei Haller wrote:
AW> > Hello,
AW> >
AW> > A friend of mine has a new Opteron based machine (Tyan Tiger K8W with two
AW> > Opteron 24?) and 4GB main memory.
AW> 
AW> Typo? Tyan Thunder?

no, it's a tiger: http://www.tyan.com/products/html/tigerk8w.html

AW> > the problem is that about 512 MB of that memory is lost (AGP aperture and
AW> > stuff). Although everything is perfect otherwise.
AW> > As far as I understand, all the PCI/AGP hardware uses the top end of the
AW> > 4GB address range to access their memory and there is just an
AW> > "overlapping" of the addresses. thus only the remaining 3.5 GB are
AW> > available.
AW> >
AW> >
AW> > Now there is an option in the BIOS called "Adjust Memory" which puts a
AW> > certain amount of memory (several choices between 64MB and 2GB) above the
AW> > 4GB address range. I tried the 2GB setting which results in 2GB main
AW> > memory at addresses 0-2GB and 2GB memory at addresses 4GB-6GB.
AW> >
AW> 
AW> Ok;
AW> 
AW> Assuming bios version 2.02.

yes

AW> The option you mention should be set to 'Auto'
AW> 
AW> Chipset->Northbridge->Memory Configuration->Adjust Memory = Auto
AW> 
AW> but set
AW> 
AW> Advanced->Cpu Configuration->MTRR Mapping = Continuous

I had "MTRR Mapping = Continuous" set all the time and tried "Adjust 
Memory" in all three modes (Auto/manual/disabled) and manual with 1 and 
2gb size.

today I had discovered the MTRR option and changed it to "discrete".
tried "Adjust Memory" manually at 2gb. 

the only working (but with loss of memory) combination seems to be "Adjust
Memory = disabled" and independant of "MTRR Mapping".

The only combination I didn't try is "MTRR Mapping=Discrete"+"Adjust
Memory= Auto". Will try tomorrow morning.


AW> That fixed it for me if I remember correctly :)

do you have a thunder or a tiger? And could you check in your BIOS setup 
whih options you used?



thanks,
        Sergei
-- 
--------------------------------------------------------------------  -?)
         eMail:       Sergei.Haller@math.uni-giessen.de               /\\
-------------------------------------------------------------------- _\_V
Be careful of reading health books, you might die of a misprint.
                -- Mark Twain
