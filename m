Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263864AbUDZOMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263864AbUDZOMv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 10:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbUDZOF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 10:05:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60394 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263945AbUDZNvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 09:51:45 -0400
Date: Mon, 26 Apr 2004 15:11:53 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@linuxmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Roland Stigge <stigge@antcom.de>,
       234976@bugs.debian.org, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
Message-ID: <20040426131152.GN2595@openzaurus.ucw.cz>
References: <1080310299.2108.10.camel@atari.stigge.org> <20040326142617.GA291@elf.ucw.cz> <1080315725.2951.10.camel@atari.stigge.org> <20040326155315.GD291@elf.ucw.cz> <1080317555.12244.5.camel@atari.stigge.org> <20040326161717.GE291@elf.ucw.cz> <1080325072.2112.89.camel@atari.stigge.org> <20040426094834.GA4901@gondor.apana.org.au> <20040426104015.GA5772@gondor.apana.org.au> <opr6193np1ruvnp2@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opr6193np1ruvnp2@laptop-linux.wpcb.org.au>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>A simple solution is to copy the pages in reverse.  This way the
> >>top page table is filled in last which should resolve this 
> >>particular
> >>issue.  The following patch does exactly that and fixes the problem
> >>for me.
> >
> >Of course this doesn't work for machines without PSE.  But then the
> >original code didn't work either.  Since resuming from 486's isn't
> >that cool anyway, IMHO someone should just add a PSE check in the
> >swsusp/pmdisk init code on i386.
> 
> There used to be such a check. Centrinos, however, if I recall 
> correctly,  don't have PSE but can suspend with our current method. 
> Perhaps we can  come up with a more nuanced test? Better still, 

Test should still be there. Switching to temporary page tables
seems to be tbe solution.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

