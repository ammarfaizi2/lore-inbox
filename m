Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbSLMLXK>; Fri, 13 Dec 2002 06:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262023AbSLMLXK>; Fri, 13 Dec 2002 06:23:10 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:57552 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261963AbSLMLXJ>; Fri, 13 Dec 2002 06:23:09 -0500
Date: Fri, 13 Dec 2002 09:30:43 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.20-rmap15b - compile failure
In-Reply-To: <3DF9BCAA.C96AA165@eyal.emu.id.au>
Message-ID: <Pine.LNX.4.50L.0212130929370.15917-100000@duckman.distro.conectiva>
References: <Pine.LNX.4.50L.0212122349520.17748-100000@imladris.surriel.com>
 <3DF9BCAA.C96AA165@eyal.emu.id.au>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2002, Eyal Lebedinsky wrote:

> I had a failure building NVIDIA_kernel/nv.c (the nvidia driver):
> http://download.nvidia.com/XFree86_40/1.0-4191/NVIDIA_kernel-1.0-4191.tar.gz
>
> It uses
> 	pte = *pte_offset(pg_mid_dir, address);
> but this patch removes pte_offset().
>
> 1) what is the correct fix (use pte_offset_kernel?)?

I'd assume so, but since I don't know exactly what the nvidia
driver does I can't tell you for sure.

> 2) in general, is it wise to remove pte_offset() or should it
>    be left for compatability?

It should be removed, otherwise some drivers would compile
but silently fail (because pte_offset() wouldn't be the right
choice from the two alternatives.

regards,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?
http://www.surriel.com/		http://guru.conectiva.com/
