Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313492AbSEEUod>; Sun, 5 May 2002 16:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313504AbSEEUoc>; Sun, 5 May 2002 16:44:32 -0400
Received: from web21501.mail.yahoo.com ([66.163.169.12]:13477 "HELO
	web21501.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S313492AbSEEUoc>; Sun, 5 May 2002 16:44:32 -0400
Message-ID: <20020505204431.74013.qmail@web21501.mail.yahoo.com>
Date: Sun, 5 May 2002 21:44:31 +0100 (BST)
From: =?iso-8859-1?q?Neil=20Conway?= <nconway_kernel@yahoo.co.uk>
Subject: Re: PATCH, IDE corruption, 2.4.18
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.30.0205051741140.23671-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
> 
> You've got been mistaken by unfortunate name (Martin changed
> name dmaproc() to udma() in 2.5.12).
> [snip]
> btw. udma() name is really misleading,
>      it should be read (u)dma() not udma() :)

Ouch, thanks for the wakeup.  I was scanning the code a little too
rapidly it seems...

Martin: why?  The old IDE code was admittedly in need of some work, but
a name like dmaproc is very obviously a function.  A name like udma is
likely to be (a) misconstrued by lusers like me as a variable, and (b)
misconstrued by all and sundry as something UDMA-specific, rather than
DMA-specific.  Would it really be too much grief to rename it back to
dmaproc()?  Misleading code will mutate into buggy code.

:-)

Now that a few people have cast their eyes over my report+patch, is it
safe to assume that the problem is real and not specific to my systems?
 Also, does anyone understand why screwing up a DMA transfer results in
the trashing of inodes?  Even better, how come this hasn't bitten many
more people?  Surely there are lots of people out there with disks and
CDs on the same IDE cable...

Neil
(PS: I have reproduced the problem on two systems so far.)

__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
