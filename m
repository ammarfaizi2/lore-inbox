Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319014AbSIDCeR>; Tue, 3 Sep 2002 22:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319019AbSIDCeR>; Tue, 3 Sep 2002 22:34:17 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:50876 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S319014AbSIDCeQ>; Tue, 3 Sep 2002 22:34:16 -0400
Date: Tue, 3 Sep 2002 23:38:26 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Robert Love <rml@tech9.net>
cc: imran.badr@cavium.com, <linux-kernel@vger.kernel.org>
Subject: Re: __get_free_pages
In-Reply-To: <1031106469.24330.3276.camel@phantasy>
Message-ID: <Pine.LNX.4.44L.0209032337330.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Sep 2002, Robert Love wrote:
> On Tue, 2002-09-03 at 22:19, Imran Badr wrote:
>
> > Does __get_free_pages(..) return physically contiguous pages?
>
> Yes.

But only if they're available. Linux doesn't currently have
any mechanisms for smart defragmentation of physical memory
and even if we had them they couldn't be fully reliable.

So be careful what you ask for, if you ask for too large a
chunk of memory you might end up not getting any at all.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

