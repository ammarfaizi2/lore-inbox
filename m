Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265589AbUEULs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265589AbUEULs0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 07:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265824AbUEULs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 07:48:26 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:53001 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S265589AbUEULsW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 07:48:22 -0400
Date: Fri, 21 May 2004 21:48:13 +1000
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp: fix swsusp with intel-agp
Message-ID: <20040521114813.GA1204@gondor.apana.org.au>
References: <20040521100734.GA31550@elf.ucw.cz> <E1BR7pl-0000Br-00@gondolin.me.apana.org.au> <20040521111612.GA976@elf.ucw.cz> <20040521111828.GA870@gondor.apana.org.au> <20040521112209.GA951@gondor.apana.org.au> <20040521114125.GA10052@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040521114125.GA10052@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2004 at 01:41:25PM +0200, Pavel Machek wrote:
> 
> I guess that open-coding #if defined() || defined() is right thing to
> do for now.
> 
> Suspend2 when/if merged might not need this... This one is not really
> specific to suspend-to-disk. It is specific to swsusp way of doing
> things, which happens to be same as pmdisk way of doing it...

Well that symbol would not apply to just this case.  We can also use
it for arch/i386/power/cpu.c itself.  It appears to be used solely for
the purpose of suspending to disk.
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
