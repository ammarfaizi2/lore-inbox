Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbUDZKwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUDZKwY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 06:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbUDZKtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 06:49:13 -0400
Received: from [203.14.152.115] ([203.14.152.115]:40967 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261576AbUDZKmg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 06:42:36 -0400
Date: Mon, 26 Apr 2004 20:40:15 +1000
To: Roland Stigge <stigge@antcom.de>, 234976@bugs.debian.org
Cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
Message-ID: <20040426104015.GA5772@gondor.apana.org.au>
References: <E1B6on4-0005EW-00@gondolin.me.apana.org.au> <1080310299.2108.10.camel@atari.stigge.org> <20040326142617.GA291@elf.ucw.cz> <1080315725.2951.10.camel@atari.stigge.org> <20040326155315.GD291@elf.ucw.cz> <1080317555.12244.5.camel@atari.stigge.org> <20040326161717.GE291@elf.ucw.cz> <1080325072.2112.89.camel@atari.stigge.org> <20040426094834.GA4901@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040426094834.GA4901@gondor.apana.org.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 07:48:34PM +1000, herbert wrote:
> 
> A simple solution is to copy the pages in reverse.  This way the
> top page table is filled in last which should resolve this particular
> issue.  The following patch does exactly that and fixes the problem
> for me.

Of course this doesn't work for machines without PSE.  But then the
original code didn't work either.  Since resuming from 486's isn't
that cool anyway, IMHO someone should just add a PSE check in the
swsusp/pmdisk init code on i386.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
