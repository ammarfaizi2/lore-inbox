Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312694AbSDKR6a>; Thu, 11 Apr 2002 13:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312696AbSDKR63>; Thu, 11 Apr 2002 13:58:29 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:54800 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S312694AbSDKR63>; Thu, 11 Apr 2002 13:58:29 -0400
Date: Thu, 11 Apr 2002 14:58:07 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Tom Rini <trini@kernel.crashing.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove compiler.h from mmap.c
In-Reply-To: <20020411175126.GE19157@opus.bloom.county>
Message-ID: <Pine.LNX.4.44L.0204111457100.31387-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2002, Tom Rini wrote:
> On Thu, Apr 11, 2002 at 02:37:23PM -0300, Rik van Riel wrote:
>
> > compiler.h is included via other include files now and its
> > #include has been removed from most C files, this patch
> > finishes the job for mm/*
>
> What #include file is mm/mmap.c getting <linux/compiler.h> from now?

slab.h -> mm.h -> sched.h -> kernel.h -> compiler.h

> Hiding (or relying on indirect) #includes isn't always a good thing...

Absolutely agreed, but likely/unlikely is such low-level
stuff that it shouldn't be included directly into .c files,
IMHO.

regards,

Rik
-- 
Will hack the VM for food.

http://www.surriel.com/		http://distro.conectiva.com/

