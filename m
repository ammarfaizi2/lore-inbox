Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262279AbRERIde>; Fri, 18 May 2001 04:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262280AbRERIdY>; Fri, 18 May 2001 04:33:24 -0400
Received: from quechua.inka.de ([212.227.14.2]:27238 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S262279AbRERIdM>;
	Fri, 18 May 2001 04:33:12 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel bug with UNIX sockets not detecting other end gone?
In-Reply-To: <Pine.LNX.4.30.0105180042440.21745-100000@ferret.lmh.ox.ac.uk> <NCBBLIEPOCNJOAEKBEAKAEPJPBAA.davids@webmaster.com>
Organization: private Linux site, southern Germany
Date: Fri, 18 May 2001 10:32:05 +0200
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E150fg7-0000D0-00@g212.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kernel does know that it has been 'disconnected'. One can even justify the
> inconcsistent behavior -- the write definitely has no place to go (now), but
> the read can't be totally sure that there is no possible way anybody could
> ever find the other end and write to it.

For a socket created with socketpair()? I'm pretty sure there is no
way for any program to find any path to it, and if there is, it's a
kernel bug. Such a socket does not have a legitimate name. (And
getsockname() reliably returns garbage, which is another bug IMHO.)

Olaf
