Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbUL0QBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbUL0QBp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 11:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbUL0QBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 11:01:45 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:21714 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261916AbUL0Pyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 10:54:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=NY0/XZtqm39JBtnLC2aAgRhlH7sBHjl2djkTXOcXypgcLrcObKT4W/JWtGeJVbiCquGW8xWC9uw4wIJ73fk1V7dnhPpQYz3yYlNr4SzydnWkXG71GoPoNkCji0G9hDpMetxIjoxqkEzsqngdzLF+NjDyg82npM3fzaHfHUI+mcU=
Message-ID: <58cb370e04122707544be6d600@mail.gmail.com>
Date: Mon, 27 Dec 2004 16:54:50 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Andreas Steinmetz <ast@domdv.de>
Subject: Re: Linux 2.6.10-ac1
Cc: Ross Biro <ross.biro@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41D02EEC.4090000@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1104103881.16545.2.camel@localhost.localdomain>
	 <58cb370e04122616577e1bd33@mail.gmail.com> <41CF649E.20409@domdv.de>
	 <58cb370e041226174019e75e23@mail.gmail.com>
	 <8783be660412270645717b89d1@mail.gmail.com>
	 <58cb370e0412270738fbc045c@mail.gmail.com> <41D02EEC.4090000@domdv.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2004 16:49:00 +0100, Andreas Steinmetz <ast@domdv.de> wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Workaround it if it is possible.  If this is really a unfixable hardware problem
> > (hard to believe - other OS-es would be also bitten by the issue) shouldn't it
> > be workaround differently anyway by something like "ide=serialize_all" (which
> > is much saner from IDE POV than "idex=serialize") ?
> 
> Bad. This would neatly kill my raid 5 setup performance wise. Call this
> idea a big step sideways. Doing a ide2=serialize leaves all three disks
> running without serialization unless the dvd-rw is used. Just to make it
> clear:
> ide0 -> onboard, 1 master (disk)
> ide1 -> onboard, 1 master (disk)
> ide2/3 -> pci, 2 master (disk,dvd-rw)
> Your idea would serialize all ide accesses which would slow down all
> disks not affected by the problem requiring serialization.

Ah, so the problem only affects native PCI IRQs.
Is it possible that it is a buggy IDE host driver not a generic IDE problem?
