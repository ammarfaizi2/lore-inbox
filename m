Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265603AbSJXTIN>; Thu, 24 Oct 2002 15:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265604AbSJXTIN>; Thu, 24 Oct 2002 15:08:13 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:14481 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S265603AbSJXTIM>; Thu, 24 Oct 2002 15:08:12 -0400
Date: Thu, 24 Oct 2002 17:14:14 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Andrea Arcangeli <andrea@suse.de>
Cc: chrisl@vmware.com, Andrew Morton <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>, <chrisl@gnuchina.org>
Subject: Re: writepage return value check in vmscan.c
In-Reply-To: <20021024184005.GT3354@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0210241713100.1648-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2002, Andrea Arcangeli wrote:

> unfortunately I see no way around it and patching the kernel to loop
> forever on dirty pages that may never be possible to write doesn't look
> safe. You could check the free space on the fs and bug the user if it
> has less than 2G free (still it's not 100% reliable, it's a racy check,
> but you could also add a 100% reliable option that slowdown the startup
> of the vm but that guarantees no corruption can happen).

We need space allocation.  Not just for this (probably rare) case,
but also for the more generic optimisation of delayed allocation.

cheers,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

