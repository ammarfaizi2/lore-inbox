Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317484AbSHBBwM>; Thu, 1 Aug 2002 21:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317605AbSHBBwM>; Thu, 1 Aug 2002 21:52:12 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:4627 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317484AbSHBBwL>; Thu, 1 Aug 2002 21:52:11 -0400
Date: Thu, 1 Aug 2002 22:55:05 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "David S. Miller" <davem@redhat.com>
cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>, <rohit.seth@intel.com>, <sunil.saxena@intel.com>,
       <asit.k.mallick@intel.com>, <gh@us.ibm.com>
Subject: Re: large page patch
In-Reply-To: <20020801.174301.123634127.davem@redhat.com>
Message-ID: <Pine.LNX.4.44L.0208012246390.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Aug 2002, David S. Miller wrote:
>    From: Andrew Morton <akpm@zip.com.au>

>    - Minimal impact on the VM and MM layers
>
> Well the downside of this is that it means it isn't transparent
> to userspace.  For example, specfp2000 results aren't going to
> improve after installing these changes.  Some of the other large
> page implementations would.

It also means we can't automatically switch to large pages for
SHM segments, which is the number one area where we need large
pages...

We should also take into account that the main application that
needs large pages for its SHM segments is Oracle, which we don't
have the source code for so we can't recompile it to use the new
syscalls introduced by this patch ...

IMHO we shouldn't blindly decide for (or against!) this patch
but also carefully look at the large page patch from RHAS (which
got added to -aa recently) and the large page patch which IBM
is working on.

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/



