Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312245AbSCRIT0>; Mon, 18 Mar 2002 03:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312243AbSCRITR>; Mon, 18 Mar 2002 03:19:17 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:17414 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S312239AbSCRITC>; Mon, 18 Mar 2002 03:19:02 -0500
Message-ID: <3C95A291.F34986A2@zip.com.au>
Date: Mon, 18 Mar 2002 00:17:21 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: fadvise syscall?
In-Reply-To: <3C945635.4050101@mandrakesoft.com> <3C945A5A.9673053F@zip.com.au> <5.1.0.14.2.20020317131910.0522b490@pop.cus.cam.ac.uk> <3C959716.6040308@mandrakesoft.com> <3C959D55.14768770@zip.com.au> <3C95A031.6070107@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> ...
> >Given this, I don't see a persuasive need to implement a non-standard
> >interface.  It takes an off_t, so posix_fadvise64() is also needed.
> >
> agreed WRT non-standard.
> 
> Are we required to have both foo and foo64 variants?  If I had my
> druthers, I would just do the foo64 version.

That would be good.  I can't see a reason why

	#define posix_fadvise posix_fadvise64

would not suffice.  That doesn't mean there isn't one :)

-
