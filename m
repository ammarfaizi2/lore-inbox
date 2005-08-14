Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbVHNUqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbVHNUqs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 16:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbVHNUqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 16:46:47 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:1685 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932278AbVHNUqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 16:46:47 -0400
Subject: Re: IT8212/ITE RAID
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Daniel Drake <dsd@gentoo.org>, CaT <cat@zip.com.au>,
       linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e050814085613ccc42c@mail.gmail.com>
References: <20050814053017.GA27824@zip.com.au>
	 <42FF263A.8080009@gentoo.org> <20050814114733.GB27824@zip.com.au>
	 <42FF3CBA.1030900@gentoo.org>
	 <1124026385.14138.37.camel@localhost.localdomain>
	 <58cb370e050814080120291979@mail.gmail.com>
	 <1124034767.14138.55.camel@localhost.localdomain>
	 <58cb370e050814085613ccc42c@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 14 Aug 2005 22:13:53 +0100
Message-Id: <1124054033.26937.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-08-14 at 17:56 +0200, Bartlomiej Zolnierkiewicz wrote:
> * your stuff was accepted after all (and some stuff like ide-cd
>   fixes was never splitted from the -ac patchset and submitted)

They were.

> * you've never provided any technical details on "the stuff I broke"

I did, several times. I had some detailed locking discussions with
Manfred and others on it as a result. The locking in the base IDE is
still broken, in fact its become worse - the random locking around
timing changes now causes some PIIX users to see double spinlock debug
with the base kernel as an example.


> > Would make sense, but I thought I had the right bits masked. Will take a
> 
> WIN_RESTORE is send unconditionally (as it always was),
> 
> This is not the right thing, somebody should go over all ATA/ATAPI
> drafts and come with the correct strategy of handling WIN_RESTORE.

Ok that would make sense. Matthew Garrett also reported some problems in
that area with suspend/resume (BIOS restoring its idea of things...)

