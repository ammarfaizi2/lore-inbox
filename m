Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264505AbUDZMNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbUDZMNp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 08:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbUDZMNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 08:13:45 -0400
Received: from [203.14.152.115] ([203.14.152.115]:48138 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S264505AbUDZMNn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 08:13:43 -0400
Date: Mon, 26 Apr 2004 22:11:45 +1000
To: ncunningham@linuxmail.com, 234976@bugs.debian.org
Cc: Roland Stigge <stigge@antcom.de>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
Message-ID: <20040426121145.GA7610@gondor.apana.org.au>
References: <1080310299.2108.10.camel@atari.stigge.org> <20040326142617.GA291@elf.ucw.cz> <1080315725.2951.10.camel@atari.stigge.org> <20040326155315.GD291@elf.ucw.cz> <1080317555.12244.5.camel@atari.stigge.org> <20040326161717.GE291@elf.ucw.cz> <1080325072.2112.89.camel@atari.stigge.org> <20040426094834.GA4901@gondor.apana.org.au> <20040426104015.GA5772@gondor.apana.org.au> <opr6193np1ruvnp2@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opr6193np1ruvnp2@laptop-linux.wpcb.org.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 09:27:13PM +1000, Nigel Cunningham wrote:
> 
> There used to be such a check. Centrinos, however, if I recall correctly,  
> don't have PSE but can suspend with our current method. Perhaps we can  

Then it's just pure luck.  Whenever you have a page whose page table
lies in a page beyond that page itself the non-PSE case will fail.

> come up with a more nuanced test? Better still, though, we should just get  
> proper AGP support for suspending and resuming in.

It's got nothing to do with AGP.  This is a flaw in the swsusp code.
It can be triggered by anything that plays with page attributes.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
