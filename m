Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282655AbRLFTRn>; Thu, 6 Dec 2001 14:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282672AbRLFTRd>; Thu, 6 Dec 2001 14:17:33 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:53766 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S282655AbRLFTR0>; Thu, 6 Dec 2001 14:17:26 -0500
Date: Thu, 6 Dec 2001 11:28:31 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Frank Cornelis <Frank.Cornelis@rug.ac.be>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: list_head makes me crazy
In-Reply-To: <Pine.GSO.4.31.0112062004520.2339-100000@eduserv.rug.ac.be>
Message-ID: <Pine.LNX.4.40.0112061126340.1603-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001, Frank Cornelis wrote:

> HELP,
>
> In include/asm-i386/processor.h, struct thread_struct I can add
> 	struct list_head *mylist;
> but not
> 	struct list_head mylist;
> while in both cases
> 	#include <linux/list.h>
> is being used.
>
> I really need this, so if anyone has the solution to my problem...
>
> Thanks in advance, Frank.

It a cross includes problem and you can declare a pointer to something
coz the pointer has a fixed size while the full struct is prohibited
because its size is unknown.




- Davide


