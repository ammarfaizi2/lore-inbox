Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267137AbTBIBmR>; Sat, 8 Feb 2003 20:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267138AbTBIBmR>; Sat, 8 Feb 2003 20:42:17 -0500
Received: from 3-157.ctame701-1.telepar.net.br ([200.193.161.157]:4740 "EHLO
	3-157.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267137AbTBIBmQ>; Sat, 8 Feb 2003 20:42:16 -0500
Date: Sat, 8 Feb 2003 23:51:50 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Jerome de Vivie <jerome.devivie@free.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: mmap inside kernel memory.
In-Reply-To: <3E45B3FF.E687EF48@free.fr>
Message-ID: <Pine.LNX.4.50L.0302082350190.12742-100000@imladris.surriel.com>
References: <3E45A7C4.8F1EBDFA@free.fr> <Pine.LNX.4.50L.0302082159460.12742-100000@imladris.surriel.com>
 <3E45B3FF.E687EF48@free.fr>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Feb 2003, Jerome de Vivie wrote:

> Here, do_mmap check if the addresse match inside current process and
> return me -ENOMEM. Are there others functions which i could use to
> associate this file and a vmalloc'ed space ?

As I said, you don't want to mmap a file in kernel memory.
You only have 128 MB of vmalloc space and you don't want to
waste it.

If you know which addresses within the file you want to
access, why don't you access them through the page cache
functions ?

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
