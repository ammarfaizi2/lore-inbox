Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265293AbTFFEEn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 00:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265294AbTFFEEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 00:04:43 -0400
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:6674 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id S265293AbTFFEEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 00:04:42 -0400
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200306060418.h564I3I24776@turbo.physics.adelaide.edu.au>
Subject: Re: Problems with scsi emulation
To: linux-kernel@vger.kernel.org
Date: Fri, 6 Jun 2003 13:48:03 +0930 (CST)
Cc: jwoithe@physics.adelaide.edu.au (Jonathan Woithe), dgilbert@interlog.com,
       agusmdp@hotmail.com
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Gilbert wrote:
> Due to many problems with DMA locking up on ATAPI writers
> earlier in the lk 2.4 series, Linux takes a very
> conservative approach and turns off DMA.

Really?  That doesn't seem to be the case with my ATAPI CD writer under stock
2.4.20.  At the start of this year I found that DMA was turned on by default
for my writer AND that having DMA turned on was usually fatal for burning (a
kernel oops would occur).  For reference an earlier posting of mine to lkml:
  http://www.ussg.iu.edu/hypermail/linux/kernel/0303.1/0384.html

> It can be turned back on with:
>   # hdparm -d 1 /dev/hdb

I found that to ensure a reliable CD writing, I had to manually turn DMA OFF
under stock 2.4.20 just to get reliable writing.  If I have DMA on I can
almost guarantee a kernel oops before the CD is complete under 2.4.20.

Given that the original correspondant was using Redhat 9.0, I'm guessing
that the advise about turning DMA back on refers to the Redhat
custom kernel in Redhat 9.0 as opposed to stock 2.4.20.  In my experience
DMA just doesn't work in stock 2.4.20 for what it's worth.

Regards
  jonathan
-- 
* Jonathan Woithe    jwoithe@physics.adelaide.edu.au                        *
*                    http://www.physics.adelaide.edu.au/~jwoithe            *
***-----------------------------------------------------------------------***
** "Time is an illusion; lunchtime doubly so"                              **
*  "...you wouldn't recognize a subtle plan if it painted itself purple and *
*   danced naked on a harpsichord singing 'subtle plans are here again'"    *
