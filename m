Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbSIZTYa>; Thu, 26 Sep 2002 15:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261459AbSIZTY3>; Thu, 26 Sep 2002 15:24:29 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:13018 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261456AbSIZTY2>; Thu, 26 Sep 2002 15:24:28 -0400
Date: Thu, 26 Sep 2002 16:29:32 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Single linked lists for Linux, overly complicated
 v2
In-Reply-To: <Pine.LNX.4.44.0209261244560.7827-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44L.0209261628490.1837-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2002, Thunder from the hill wrote:

> We don't know the parent structure. We shouldn't know it, since it takes
> time. So I try to keep the address pointer stable instead of just
> exchanging pointers.

In the case of slist_del() you HAVE to know it.

Think about removing a single entry from the middle of
the list ... the entries before and after need to stay
on the list.

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

