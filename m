Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273520AbRIQHrs>; Mon, 17 Sep 2001 03:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273519AbRIQHri>; Mon, 17 Sep 2001 03:47:38 -0400
Received: from pat.uio.no ([129.240.130.16]:49795 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S273514AbRIQHr3>;
	Mon, 17 Sep 2001 03:47:29 -0400
To: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Cc: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac11
In-Reply-To: <200109170049.f8H0nkEa008317@sleipnir.valparaiso.cl>
	<m366ail5pp.fsf@giants.mandrakesoft.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 17 Sep 2001 09:47:42 +0200
In-Reply-To: Chmouel Boudjnah's message of "17 Sep 2001 07:57:38 +0200"
Message-ID: <shsvgiicl7l.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Chmouel Boudjnah <chmouel@mandrakesoft.com> writes:

     > Horst von Brand <vonbrand@sleipnir.valparaiso.cl> writes:
    >> Boots and panics immediately "trying to kill init"

     > Backout the changes to fs/locks.c or the patch of Trond :

     > http://marc.theaimsgroup.com/?l=linux-kernel&m=100019824200351&w=2

Huh? WTF does a patch to the locking code have to do with init?

That particular code is only called if something closes a file on
which POSIX locks are applied. Init doesn't use locking.
The patch *is* required in Alan's tree. Without it, 2 processes that
lock the same file can race and corrupt the i_flock list.

Cheers,
   Trond
