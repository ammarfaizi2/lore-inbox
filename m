Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbVJCXXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbVJCXXE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 19:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbVJCXXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 19:23:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:25753 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932465AbVJCXXB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 19:23:01 -0400
Date: Tue, 4 Oct 2005 00:22:44 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ryan Anderson <ryan@autoweb.net>,
       Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>,
       Luben Tuikov <luben_tuikov@adaptec.com>, andrew.patterson@hp.com,
       Marcin Dalecki <dalecki.marcin@neostrada.pl>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, dougg@torque.net,
       Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into the kernel
Message-ID: <20051003232244.GZ7992@ftp.linux.org.uk>
References: <1128114950.10079.170.camel@bluto.andrew> <433DB5D7.3020806@adaptec.com> <9B90AC8A-A678-4FFE-B42D-796C8D87D65B@neostrada.pl> <4341381D.2060807@adaptec.com> <E93AC7D5-4CC0-4872-A5B8-115D2BF3C1A9@neostrada.pl> <1128357350.10079.239.camel@bluto.andrew> <43415EC0.1010506@adaptec.com> <Pine.BSO.4.62.0510032103380.28198@rudy.mif.pg.gda.pl> <1128377075.23932.5.camel@ryan2.internal.autoweb.net> <Pine.LNX.4.64.0510031531170.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510031531170.31407@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 03:56:50PM -0700, Linus Torvalds wrote:
> For example, Al Viro pointed out privately that the C preprocessor spec 
> actually matches what a C preprocessor is supposed to do, and that it was 
> easy to generate code from the spec. The reason? The code existed first, 
> the spec was written from that. Writing it back into software "just 
> works", because the spec really _was_ software to begin with, just 
> re-written as a spec.

Not quite, AFAIK.  Existing code was a fscking mess of subtly incompatible
implementations; the thing that had helped was simple - the people who
would have to implement the damn thing had a lot of presense in the
committee.  So it boiled down to
	* observation: attempt to describe it as text transformation leads
to horrors; it really acts on token stream; give up treating it like a text
filter.
	* after figuring out what it should do to sequences of tokens they
ended up with a reasonably simple algorithm that matched the existing
behaviour sans the nasty corner cases everyone handled differently.
	* _that_ had been turned into spec.
