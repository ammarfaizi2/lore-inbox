Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261416AbSJMD2w>; Sat, 12 Oct 2002 23:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261417AbSJMD2w>; Sat, 12 Oct 2002 23:28:52 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:37040 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261416AbSJMD2v>; Sat, 12 Oct 2002 23:28:51 -0400
Date: Sun, 13 Oct 2002 01:34:22 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Hu Gang <hugang@soulinfo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: patch for 2.5.42. 2/2
In-Reply-To: <20021013112019.496010fc.hugang@soulinfo.com>
Message-ID: <Pine.LNX.4.44L.0210130133070.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44L.0210130133072.22735@imladris.surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Oct 2002, Hu Gang wrote:

> --- linux-2.5.42/drivers/net/3c59x.c	Sat Oct 12 21:25:00 2002
> +++ linux-2.5.42-suspend/drivers/net/3c59x.c	Sat Oct 12 21:20:48 2002

> +#ifdef CONFIG_PM
> +	int in_suspend;
> +#endif

This looks like a serious design mistake.  Surely it would be
better to just have the network layer stop operations when the
system is going into suspend, instead of having to modify 100
individual network drivers ?

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

