Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262304AbSJ0IRX>; Sun, 27 Oct 2002 03:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262310AbSJ0IRW>; Sun, 27 Oct 2002 03:17:22 -0500
Received: from smtp.mailix.net ([216.148.213.132]:41799 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id <S262304AbSJ0IRV>;
	Sun, 27 Oct 2002 03:17:21 -0500
Date: Sun, 27 Oct 2002 10:23:37 +0100
From: Alex Riesen <fork0@users.sf.net>
To: Vladimir Trebicky <guru@cimice.yo.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Swap doesn't work
Message-ID: <20021027092337.GA4507@steel>
Reply-To: Alex Riesen <fork0@users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001001c27d02$6297fe50$4500a8c0@cybernet.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've made my linux-from-scratch with latest stable (2.4.19) kernel, made
> swap, turned it on but it doesn't work. It seems it does but when there's
> not enough memory, the system crashes. Either it kills the application
> desiring more memory (gcc or something) or crashes the kernel with memory
> dump. Neither the 2.4.20-pre5-ac3 helped.

Does your swap partition show up in /proc/swaps? It has to contain
something like this:

Filename			Type		Size	Used	Priority
/dev/hda6                       partition	506008	0	-1

Btw, do you see something swap-related in dmesg? Like:

  Unable to find swap-space signature
  Unable to handle swap header version ...
  Swap area shorter than signature indicates
  Empty swap-file

And do you actually see something like this:
  Adding Swap: 506008k swap-space (priority -1)

How did you initialized the swap partition? Recent kernels support both
v1 and v2 swaps, which is can be set for mkswap using -v0 (-v1).
Actually i mean did you initialized it at all? 8)

-alex
