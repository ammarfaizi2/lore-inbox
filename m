Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267619AbUJIXon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267619AbUJIXon (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 19:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267624AbUJIXon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 19:44:43 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:23288 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267619AbUJIXoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 19:44:23 -0400
Message-ID: <58cb370e04100916441c1b74d@mail.gmail.com>
Date: Sun, 10 Oct 2004 01:44:23 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Martins Krikis <mkrikis@yahoo.com>
Subject: Re: [Announce] "iswraid" (ICH5R/ICH6R ataraid sub-driver) for 2.4.28-pre3
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
In-Reply-To: <20041009230300.75239.qmail@web13724.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200410092337.36488.bzolnier@elka.pw.edu.pl>
	 <20041009230300.75239.qmail@web13724.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Oct 2004 16:03:00 -0700 (PDT), Martins Krikis
<mkrikis@yahoo.com> wrote:
> --- Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl> wrote:
> 
> > I may sound like an ignorant but...
> >
> > Why can't device mapper be merged into 2.4 instead?
> 
> "Instead" is the key word here... That would mean that
> Boji's and my work has been largely in vain and that the
> driver that to my best knowledge currently provides the
> simplest (from a user's point of view) cooperation with
> Intel RAID OROM and the most comlete feature-set regarding
> Intel RAID metadata interpretation and updates would not
> make it to the kernel. I have nothing against device mapper
> being merged into 2.4 but I don't consider that a fair
> reason for not considering iswraid.

Well, in some way this speaks against merging iswraid in 2.4.
If it provides "the most comlete feature-set regarding Intel RAID
metadata interpretation and updates" then merging it would
create regression when compared to 2.6, wouldn't it?

> > Is there something wrong with 2.4 device mapper patch?
> 
> I don't think so. However, I do believe that iswraid has
> some advantages, one of them being the ability to just link
> it statically with the rest of the kernel and not needing
> any user-space support code, i.e., initrd is not necessary.

Yep, no doubt it is easier to use but harder to maintain.

> Also, I do not believe that dm+dmraid are currently
> capable of updating the Intel RAID metadata in case of
> errors. Please correct me if I'm wrong.

again "regression" argument is valid here

> > It would more convenient (same driver for 2.4 and 2.6)
> > and would benefit users of other software RAIDs
> > (easier transition to 2.6).
> 
> If you expect the transitioning from ataraid to dm+dmraid
> to be so hard that it is best to do it separately from
> the switch to a 2.6 kernel, then I think 2 things are true:

Maybe not hard but inconvinient.

> 1) there might be something positive about the simple
> usage of ataraid subdrivers,

Yep.

> 2) the users of Intel RAID metadata might benefit by
> having two drivers supporting them in 2.4 kernels---the
> one with the "simple, ataraid-style" usage and "the one
> for the future".

Yep.

> My email archive and the feedback on iswraid's project
> page actually contains many requests for an iswraid port
> to 2.6. Which I'm reading as a sign that some users
> actually like it.

iswraid and 2.6 is a no go for obvious reason (no ataraid)

> The main features of iswraid are listed in
> Documentation/iswraid.txt, almost at the top of the file.
> I believe that several of them distingiush it from
> other ataraid subdrivers in a positive way, and there
> was certainly a lot of hard work that went into this driver.

No doubt about that.

I'm fine with merging iswaid into 2.4 but it is a bit shame that
the same amount of work didn't go into improving Intel RAID
support in 2.6.

> I don't know how dm+dmraid would compare, but if you do,
> I'll be most interested to learn about it.
>
> 
> 
>   Martins Krikis
>   Storage Components Division
>   Intel Massachusetts
