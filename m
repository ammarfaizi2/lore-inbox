Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265847AbUHVDTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbUHVDTb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 23:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUHVDTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 23:19:31 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:62159 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265847AbUHVDT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 23:19:29 -0400
Subject: Re: [PATCH] ppc32 use simplified mmenonics
From: Albert Cahalan <albert@users.sf.net>
To: tab@snarc.org
Cc: benh@kernel.crashing.org,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1093135526.5759.2513.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 21 Aug 2004 20:45:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch substitutes complex rlwinm instruction
> to the simplied instruction clrrwi when possible.
>
> This has the same meaning as the ppc knows only about
> rlwinm; clrrwi is just a language simplification.
>
> basicly it's a : s/rlwinm R1,R2,0,0,31-N/clrrwi R1,R2,N/
>
> Please apply or comments,

I'd rather you went the other way, replacing these
barely-documented instructions with ones that are
easy to look up. Motorola has about a zillion of
these "simplified" instructions. I guess Motorola
and IBM were jealous of Intel's CISC instructions.

The big problem is this:
        THESE ARE NOT IN THE INDEX!!!!!!

So, if I forget what one of these many instructions
does, I'll have quite the time paging through the
manual trying to find it.

If it's not in the index, please avoid it.


