Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271130AbRHOKlH>; Wed, 15 Aug 2001 06:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271131AbRHOKk5>; Wed, 15 Aug 2001 06:40:57 -0400
Received: from mail.webmaster.com ([216.152.64.131]:11194 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S271130AbRHOKki>; Wed, 15 Aug 2001 06:40:38 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: RFC: poll change
Date: Wed, 15 Aug 2001 03:40:50 -0700
Message-ID: <NOEJJDACGOHCKNCOGFOMAEDJDDAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20010814.154233.98555395.davem@redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0006
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>    From: Herbert Xu <herbert@gondor.apana.org.au>
>    Date: Wed, 15 Aug 2001 08:38:02 +1000
>
>    Hmm, it still seems to be wrong:
>  ...
>
>            if (nfds > current->files->max_fds)
>                    nfds = current->files->max_fds;
>
>    The second if statement should be removed.  And it might be
> better to use
>    current->rlim[RLIMIT_NOFILE].rlim_cur instead of NR_OPEN.
>
> It has to be limited to "max_fds", that is how many files we may
> legally address in current->files!

	Though stupid, I believe it is perfectly legal to, say, have one socket
open and poll for it with two separate entries, one checking readability and
one checking writability.

	DS

