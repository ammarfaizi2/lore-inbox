Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263589AbSLSNrR>; Thu, 19 Dec 2002 08:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264004AbSLSNrR>; Thu, 19 Dec 2002 08:47:17 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:51277 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S263589AbSLSNrQ>; Thu, 19 Dec 2002 08:47:16 -0500
Date: Thu, 19 Dec 2002 14:55:15 +0100 (CET)
From: bart@etpmod.phys.tue.nl
Reply-To: bart@etpmod.phys.tue.nl
Subject: Re: Intel P6 vs P7 system call performance
To: davej@codemonkey.org.uk
Cc: torvalds@transmeta.com, lk@tantalophile.demon.co.uk, hpa@transmeta.com,
       terje.eggestad@scali.com, drepper@redhat.com, matti.aarnio@zmailer.org,
       hugh@veritas.com, mingo@elte.hu, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Message-Id: <20021219135517.7E78051FB6@gum12.etpnet.phys.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Dec, Dave Jones wrote:
> On Thu, Dec 19, 2002 at 02:22:36PM +0100, bart@etpmod.phys.tue.nl wrote:
>  > > However, there's another issue, namely process startup cost. I personally 
>  > > want it to be as light as at all possible. I hate doing an "strace" on 
>  > > user processes and seeing tons and tons of crapola showing up. Just for 
>  > So why not map the magic page at 0xffffe000 at some other address as
>  > well? 
>  > Static binaries can just directly jump/call into the magic page.
> 
> .. and explode nicely when you try to run them on an older kernel
> without the new syscall magick. This is what Linus' first
> proof-of-concept code did.


True, but unless I really don't get it, compatibility of a new static
binary with an old kernel is going to break anyway. 
My point was that the double-mapped page trick adds no overhead in the
case of a static binary, and just one extra mmap in case of a shared
binary.

Bart

> 
> 		Dave
> 

-- 
Bart Hartgers - TUE Eindhoven 
http://plasimo.phys.tue.nl/bart/contact.html
