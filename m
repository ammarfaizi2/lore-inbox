Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267526AbUJIXDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267526AbUJIXDI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 19:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267543AbUJIXDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 19:03:07 -0400
Received: from web13724.mail.yahoo.com ([66.163.176.63]:41378 "HELO
	web13724.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267526AbUJIXDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 19:03:01 -0400
Message-ID: <20041009230300.75239.qmail@web13724.mail.yahoo.com>
Date: Sat, 9 Oct 2004 16:03:00 -0700 (PDT)
From: Martins Krikis <mkrikis@yahoo.com>
Subject: Re: [Announce] "iswraid" (ICH5R/ICH6R ataraid sub-driver) for 2.4.28-pre3
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com,
       mkrikis@yahoo.com
In-Reply-To: <200410092337.36488.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl> wrote:

> I may sound like an ignorant but...
> 
> Why can't device mapper be merged into 2.4 instead?

"Instead" is the key word here... That would mean that
Boji's and my work has been largely in vain and that the
driver that to my best knowledge currently provides the
simplest (from a user's point of view) cooperation with
Intel RAID OROM and the most comlete feature-set regarding
Intel RAID metadata interpretation and updates would not
make it to the kernel. I have nothing against device mapper
being merged into 2.4 but I don't consider that a fair
reason for not considering iswraid.
 
> Is there something wrong with 2.4 device mapper patch?

I don't think so. However, I do believe that iswraid has
some advantages, one of them being the ability to just link
it statically with the rest of the kernel and not needing
any user-space support code, i.e., initrd is not necessary.
Also, I do not believe that dm+dmraid are currently
capable of updating the Intel RAID metadata in case of
errors. Please correct me if I'm wrong.

> It would more convenient (same driver for 2.4 and 2.6)
> and would benefit users of other software RAIDs
> (easier transition to 2.6).

If you expect the transitioning from ataraid to dm+dmraid
to be so hard that it is best to do it separately from
the switch to a 2.6 kernel, then I think 2 things are true:
1) there might be something positive about the simple
usage of ataraid subdrivers,
2) the users of Intel RAID metadata might benefit by
having two drivers supporting them in 2.4 kernels---the
one with the "simple, ataraid-style" usage and "the one
for the future".

My email archive and the feedback on iswraid's project
page actually contains many requests for an iswraid port
to 2.6. Which I'm reading as a sign that some users
actually like it.

The main features of iswraid are listed in
Documentation/iswraid.txt, almost at the top of the file.
I believe that several of them distingiush it from 
other ataraid subdrivers in a positive way, and there
was certainly a lot of hard work that went into this driver.
I don't know how dm+dmraid would compare, but if you do,
I'll be most interested to learn about it.

  Martins Krikis
  Storage Components Division
  Intel Massachusetts



		

