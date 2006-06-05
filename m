Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750784AbWFEVHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWFEVHD (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 17:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWFEVHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 17:07:01 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:21148 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S1750784AbWFEVHA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 17:07:00 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200606052101.k55L1YJM010151@wildsau.enemy.org>
Subject: Re: UDF: buggy? libdvdread vs. udf fs driver
In-Reply-To: <200606052056.k55Ku7mR010143@wildsau.enemy.org>
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
Date: Mon, 5 Jun 2006 23:01:34 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> a closer look reveals that wrudf tries to read() into
> a buffer-address of NIL.

and the winner is .... 

initIO() !

it will malloc() a 64kb buffer. but only if medium==CDRW.
if the medium is a diskimage, the buffer-pointer will
remain 0x0000000 (or "NIL").

kind regards,
h.rosmanith
