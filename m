Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132891AbRDSTD4>; Thu, 19 Apr 2001 15:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132894AbRDSTDq>; Thu, 19 Apr 2001 15:03:46 -0400
Received: from quechua.inka.de ([212.227.14.2]:7255 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S132860AbRDSTDH>;
	Thu, 19 Apr 2001 15:03:07 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: light weight user level semaphores
In-Reply-To: <023c01c0c8a9$a4bb9940$910201c0@zapper> <Pine.LNX.4.31.0104190849170.3842-100000@penguin.transmeta.com>
Organization: private Linux site, southern Germany
Date: Thu, 19 Apr 2001 20:48:59 +0200
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E14qJUB-0001XF-00@g212.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> problems: just _how_ high woul dyou move it? Would it potentially disturb
> an application that opens thousands of files, and knows that they get
> consecutive file descriptors? Which is _legal_ and well-defined in UNIX.

Only if you close them before. The process may have been started with
arbitrary fds open.

> say "if you use fast semaphores, they use file descriptors and you should
> no longer depend on consecutive fd's".

Which you cannot anyway. Already some library routines can open fds
although they don't explicitly say so and don't have to in all
implementations, like openlog() or all the get*by*() stuff (or even
dlopen()), so you are never sure to know which or how many FDs you
actually have open.

Olaf
