Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269140AbRHLMCZ>; Sun, 12 Aug 2001 08:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269137AbRHLMCP>; Sun, 12 Aug 2001 08:02:15 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8205 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269134AbRHLMCK>; Sun, 12 Aug 2001 08:02:10 -0400
Subject: Re: Bug report : Build problem with kernel 2.4.8
To: cupotka@pisem.net (CuPoTKa)
Date: Sun, 12 Aug 2001 13:04:26 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel),
        kbuild-devel@lists.sourceforge.net (kbuild-devel),
        alan@redhat.com (alan), kaos@ocs.com.au
In-Reply-To: <no.id> from "CuPoTKa" at Aug 12, 2001 01:21:27 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Vtyk-0005dy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Problem: Can't compile kernel 2.4.8 with support of sound card CM8338A.

Its a bug in the code

> In file included from cmpci.c:90:
> /usr/local/src/kernel-source-2.4.8/include/linux/module.h:21: linux/mod=
> versions.h: No such file or directory

drivers/sound/cmpci.c included <linux/modversions.h> directly so broke if
you didnt have module versioning enabled. I've already sent Linus a fix
for this one
