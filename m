Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289021AbSAFUKq>; Sun, 6 Jan 2002 15:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289022AbSAFUKh>; Sun, 6 Jan 2002 15:10:37 -0500
Received: from sm14.texas.rr.com ([24.93.35.41]:34753 "EHLO sm14.texas.rr.com")
	by vger.kernel.org with ESMTP id <S289021AbSAFUKb>;
	Sun, 6 Jan 2002 15:10:31 -0500
Message-Id: <200201062011.g06KBpu3007487@sm14.texas.rr.com>
Content-Type: text/plain; charset=US-ASCII
From: Marvin Justice <mjustice@austin.rr.com>
Reply-To: mjustice@austin.rr.com
To: Daniel Freedman <freedman@ccmr.cornell.edu>
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
Date: Sun, 6 Jan 2002 14:15:24 -0600
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020106133939.A6408@ccmr.cornell.edu> <200201061856.g06IuXma007731@sm13.texas.rr.com> <20020106144525.B6408@ccmr.cornell.edu>
In-Reply-To: <20020106144525.B6408@ccmr.cornell.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 January 2002 01:45 pm, Daniel Freedman wrote:
> Hi Marvin,
>
> Thanks for the quick reply.
>
> On Sun, Jan 06, 2002, Marvin Justice wrote:
> > Is this what your looking for? Just below the definition of PAGE_OFFSET
> > in page.h:
> >
> > /*
> >  * This much address space is reserved for vmalloc() and iomap()
> >  * as well as fixmap mappings.
> >  */
> > #define __VMALLOC_RESERVE	(128 << 20)
>
> However, while it does seem to be exactly the definition for 128MB
> vmalloc offset that I was looking for, I don't seem to have this
> definition in my source tree (2.4.16):
>
>   freedman@planck:/usr/src/linux$ grep -r __VMALLOC_RESERVE *
>   freedman@planck:/usr/src/linux$
>
> Any idea why this is so?
>
> Thanks again,
>
> Daniel
>

Hmmm. Looks like it was moved sometime between 2.4.16 and 2.4.18pre1. In my 
2.4.16 tree it's located in arch/i386/kernel/setup.c and without the leading 
underscores.

-M
