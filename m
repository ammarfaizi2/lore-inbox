Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319099AbSHMSfu>; Tue, 13 Aug 2002 14:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319122AbSHMSfu>; Tue, 13 Aug 2002 14:35:50 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43791 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319099AbSHMSfu>; Tue, 13 Aug 2002 14:35:50 -0400
Date: Tue, 13 Aug 2002 11:41:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Christoph Hellwig <hch@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] CLONE_SETTLS, CLONE_SETTID, 2.5.31-BK
In-Reply-To: <Pine.LNX.4.44.0208132025530.6752-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208131138500.7411-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Ingo Molnar wrote:
> 
>     CLONE_SETTLS => if present then the third clone() syscall parameter
>                     is the new TLS.
> 
>     CLONE_SETTID => if present then the child TID is written to the
>                     address specified by the fourth clone() parameter.

Except you actually test the CLONE_SETTLS bit..

This looks basically ok, although that "struct thread_struct *t" still 
serves no useful purpose..

		Linus

