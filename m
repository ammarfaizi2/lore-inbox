Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285276AbRLFWoD>; Thu, 6 Dec 2001 17:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285269AbRLFWoB>; Thu, 6 Dec 2001 17:44:01 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64786 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285255AbRLFWmL>; Thu, 6 Dec 2001 17:42:11 -0500
Subject: Re: Kernel 2.4.16 & Heavy I/O
To: riel@conectiva.com.br (Rik van Riel)
Date: Thu, 6 Dec 2001 22:50:39 +0000 (GMT)
Cc: mikeg@wen-online.de (Mike Galbraith),
        roy@karlsbakk.net (Roy Sigurd Karlsbakk),
        pablo.borges@uol.com.br (Pablo Borges), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0112061737480.2283-100000@duckman.distro.conectiva> from "Rik van Riel" at Dec 06, 2001 05:56:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16C7Lj-0003O4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Once a page is used twice, it's not a candidate for eviction
> until (most of) the use-once pages are gone.
> 
> This means that if you have these 40 MB of used-twice-but-never-again
> buffer cache memory, this memory will never be evicted until other
> pages get promoted from use-once to active.

Its worth noting btw that you can intentionally exploit this in an app
to get unfair use of memory. That makes me very dubious about the heuristic

Alan
