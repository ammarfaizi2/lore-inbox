Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264275AbUGHLRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbUGHLRs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 07:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUGHLRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 07:17:48 -0400
Received: from chaos.analogic.com ([204.178.40.224]:57221 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264275AbUGHLRq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 07:17:46 -0400
Date: Thu, 8 Jul 2004 07:10:12 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, jmorris@redhat.com,
       mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
In-Reply-To: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
Message-ID: <Pine.LNX.4.53.0407080707010.21439@chaos>
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jul 2004, Herbert Xu wrote:

> Chris Wright <chrisw@osdl.org> wrote:
> > Fixup another round of sparse warnings of the type:
> >        warning: Using plain integer as NULL pointer
>
> What's wrong with using 0 as the NULL pointer? In contexts where
> a plain 0 is unsafe, NULL is usually unsafe as well.
>
> Cheers,
> --

Because NULL is a valid pointer value. 0 is not. If you were
to make 0 valid, you would use "(void *)0", which is what
NULL just happens to be in all known architectures so far,
although that could change in an alternate universe.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


