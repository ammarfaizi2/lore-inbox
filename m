Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUISVsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUISVsK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 17:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbUISVsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 17:48:10 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:37104 "EHLO
	merkurneu.hrz.uni-giessen.de") by vger.kernel.org with ESMTP
	id S264377AbUISVsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 17:48:01 -0400
Date: Mon, 20 Sep 2004 07:47:20 +1000 (EST)
From: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
X-X-Sender: gc1007@fb07-calculator.math.uni-giessen.de
To: jonathan@jonmasters.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: lost memory on a 4GB amd64
In-Reply-To: <35fb2e59040919130154966337@mail.gmail.com>
Message-Id: <Pine.LNX.4.58.0409200737010.3644@fb07-calculator.math.uni-giessen.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au> 
 <200409161528.19409.andrew@walrond.org> 
 <Pine.LNX.4.58.0409170051200.26494@fb07-calculator.math.uni-giessen.de> 
 <200409161619.28742.andrew@walrond.org> 
 <Pine.LNX.4.58.0409170147320.26494@fb07-calculator.math.uni-giessen.de> 
 <Pine.LNX.4.58.0409190007530.31971@fb07-calculator.math.uni-giessen.de>
 <35fb2e59040919130154966337@mail.gmail.com>
Organization: University of Giessen * Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2004, Jon Masters (JM) wrote:

JM> On Sun, 19 Sep 2004 00:18:38 +1000 (EST), Sergei Haller 
JM> 
JM> > * if the memory configuration is as follows: the first 3gb ar at the
JM> >   normal address range, the fourth gb is at the address range 4-5gb.
JM> >   then all 4gb are available (not quite -- a few mb ere missing, but
JM> >   thats ok) and
JM> >    - the SMP kernel panics as soon as I start X
JM> 
JM> Just out of interest - can you say what tests you ran here - for
JM> example whether you tried allocating large amounts of memory from a
JM> userspace process without running X and/or touching bits of memory
JM> mapped hardware? You say a kernel compile works fine so can you rule
JM> out this being X taking down the system (you're previous mail seemed
JM> somehat unclear).

- as soon as I start X, the machine is gone.
- if I compile the kernel (without X of course) its ok.

the machine is supposed to be for scientific calculations and we run magma 
on it. The test I ran is just a one-liner which creates a matrix of size
20000x20000 with zeros in it. so basically it just allocates 1.6gb of 
memory and writes zeros in it. the SMP kernel with the above memory 
configuration crashes immediately.

I guess I should write a simple C-program using malloc or something to 
reproduce the crash in the simplest possible way, shouldn't I?

        Sergei
-- 
--------------------------------------------------------------------  -?)
         eMail:       Sergei.Haller@math.uni-giessen.de               /\\
-------------------------------------------------------------------- _\_V
Be careful of reading health books, you might die of a misprint.
                -- Mark Twain
