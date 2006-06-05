Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750883AbWFEVNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWFEVNo (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 17:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWFEVNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 17:13:44 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:21916 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S1750853AbWFEVNn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 17:13:43 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200606052108.k55L8HGI010159@wildsau.enemy.org>
Subject: Re: UDF: buggy? libdvdread vs. udf fs driver
In-Reply-To: <200606052101.k55L1YJM010151@wildsau.enemy.org>
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
Date: Mon, 5 Jun 2006 23:08:17 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> it will malloc() a 64kb buffer. but only if medium==CDRW.
> if the medium is a diskimage, the buffer-pointer will
> remain 0x0000000 (or "NIL").

oh, to be more precise: initIO() reads:
  if (device_type==DISK_IMAGE)
    return 0;

the malloc() loop is below the if statement.
I'll try to fix it w/o breaking other things :-/

kind regards,
h.rosmanith
