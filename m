Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317803AbSGKJo0>; Thu, 11 Jul 2002 05:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317805AbSGKJoZ>; Thu, 11 Jul 2002 05:44:25 -0400
Received: from users-vst.linvision.com ([62.58.92.114]:45955 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S317803AbSGKJoY>; Thu, 11 Jul 2002 05:44:24 -0400
Message-Id: <200207110946.LAA08800@cave.bitwizard.nl>
Subject: Re: [STATUS 2.5]  July 10, 2002
In-Reply-To: <E17SOg4-0007oM-00@the-village.bc.nu> from Alan Cox at "Jul 10,
 2002 10:07:12 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 11 Jul 2002 11:46:10 +0200 (MEST)
CC: Cort Dougan <cort@fsmlabs.com>, Robert Love <rml@tech9.net>,
       Ville Herva <vherva@niksula.hut.fi>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-notice: Read http://www.bitwizard.nl/cou.html for the licence to my Emailaddr.
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(I missed part of this thread. I hope I correcltly deduced that you
guys are talking about the improved disk troughput when increasing the
HZ clock rate ... )


Alan Cox wrote:
> > Why was the rate incremented to maintain interactive performance?  Wasn't
> > that the whole idea of the pre-empt work?  Does the burden of pre-empt
> > actually require this?
> 
> Bizarrely in many cases it increases throughput

IMHO, This is a hint that there is something not quite right with the
scheduler.

This effect has been reported here a couple of times. 

If increasing the timer rate improves disk throughput that means that
the disk-reading process is not scheduled immediately following the
disk interrupt, but is somehow left waiting until the next timer
tick....

It should be scheduled "immediately" even if there is another
cpu-eating process: the scheduling heuristics should help there... 

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
