Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317631AbSFLFhD>; Wed, 12 Jun 2002 01:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317632AbSFLFhC>; Wed, 12 Jun 2002 01:37:02 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:8366 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317631AbSFLFhC>; Wed, 12 Jun 2002 01:37:02 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH, TRIVIAL] Fix argument of BLKGETSIZE64 
In-Reply-To: Your message of "Wed, 12 Jun 2002 15:02:00 +1000."
             <15622.54728.469214.307901@wombat.chubb.wattle.id.au> 
Date: Wed, 12 Jun 2002 15:41:23 +1000
Message-Id: <E17I0sl-0004y0-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <15622.54728.469214.307901@wombat.chubb.wattle.id.au> you write:
> 
> (2.5.21)  The third argument to BLKGETSIZE64 is declared as u64 in
> include/linux/fs.h
...
> -#define BLKGETSIZE64 _IOR(0x12,114,sizeof(u64))        /* 
> +#define BLKGETSIZE64 _IOR(0x12,114,sizeof(uint64_t))   /* 

This is a wider question: uint64_t and int64_t (et. al) are ISO C
<stdint.h> requirements.  Whether we should begin migration in 2.5, or
leave them alone is a Linus question.

> I think it should be uint64_t to allow glibc to copy and mangle the file into
> its header tree. 

I don't think that's really an issue, is it?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
