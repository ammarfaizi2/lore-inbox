Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267023AbTBXTz1>; Mon, 24 Feb 2003 14:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267038AbTBXTz1>; Mon, 24 Feb 2003 14:55:27 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:30106 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S267023AbTBXTz0>; Mon, 24 Feb 2003 14:55:26 -0500
Message-Id: <200302242005.VAA04400@post.webmailer.de>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
To: root@chaos.analogic.com, schwidefsky@de.ibm.com,
       linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Date: Mon, 24 Feb 2003 21:03:13 +0100
References: <20030224195008$59ef@gated-at.bofh.it> <20030224195008$40bd@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> I think you must keep these warnings in! There are many bugs
> that these uncover uncluding loops that don't terminate correctly
> but seem to work for "most all" cases. These are the hard-to-find
> bugs that hit you six months after release.

This was my change. Obviously the warning is a good idea in general,
but I don't see the point of scrolling through hundreds of lines
with the same warning in someone else's code. I actually plan to fix
these warnings in arch/s390 and drivers/s390 as well as include/
and make the s390 kernel compile with -Werror, but the rest looks 
more like a task for the Janitors. Note that before gcc-3.3, 
-Wsign-compare has not been part of -Wall.

        Arnd <><
