Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWACSfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWACSfm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 13:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWACSfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 13:35:42 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:25749 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932473AbWACSfl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 13:35:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FTq97xXg+ADwmLnUpR6zsPnu977yPdGKmtFpZovfXwG9C1FVlU3KROlst35w4V/5m3NtzSS/cGHtToLx2/HoDkfzwQSOJPs2TQeHoaU46QXkaM+jVPJ9qLVX4PMEi8LPtPnslnvc7scHx93CKXgnIBYYDx8SIJorZpwaYrXtsvs=
Message-ID: <58cb370e0601031035x89bd6cbw1e1efb3f7a93bb41@mail.gmail.com>
Date: Tue, 3 Jan 2006 19:35:39 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [git patches] 2.6.x libata updates
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <43BAB7D4.4050204@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060103164319.GA402@havoc.gtf.org>
	 <58cb370e0601030851w62fc917bibe0fd5069b2f3e44@mail.gmail.com>
	 <1136309555.22598.10.camel@localhost.localdomain>
	 <43BAB7D4.4050204@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> Alan Cox wrote:
> > On Maw, 2006-01-03 at 17:51 +0100, Bartlomiej Zolnierkiewicz wrote:
> >
> >>>+ * with SITRE and the 0x44 timing register). See pata_oldpiix and pata_mpiix
> >>>+ * for the early chip drivers.
> >>
> >>pata_oldpiix and pata_mpiix are not in the mainline
> >
> >
> > They are probably ready for mainline and since Linux currently has no
> > support for either it might be nice to get them in. Anything specific
> > they need polishing for Jeff ?
>
> Not really.  If there's no support in mainline, I'm ok with pushing them
> upstream...  provided that they have been tested and verified to work on
> at least one machine?  :)

All chipsets are supported by piix.c driver but:

* we depend on BIOS to program correct PIO timings and set drives
  (mpiix chipset)

* PIO tuning code is buggy and needs fixing (oldpiix chipsets)

I don't think that this alone justify adding new drivers instead of fixing
old one as both issues can be fixed quite easily by almost cut'n'pasting
new tuning code from Alan's drivers and adding it to piix.c.

Bartlomiej
