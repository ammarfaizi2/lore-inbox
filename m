Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281645AbRLAMtq>; Sat, 1 Dec 2001 07:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284092AbRLAMtg>; Sat, 1 Dec 2001 07:49:36 -0500
Received: from mail020.mail.bellsouth.net ([205.152.58.60]:5690 "EHLO
	imf20bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281645AbRLAMt1>; Sat, 1 Dec 2001 07:49:27 -0500
Message-ID: <3C08D1D1.F3EAC851@mandrakesoft.com>
Date: Sat, 01 Dec 2001 07:49:21 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] if (foo) kfree(foo) /fs cleanup
In-Reply-To: <E16A9WI-00073W-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> IMHO this is precisely the wrong thing to do.
> 
> We should make the = NULL check within kfree do a BUG() call. That way we
> fix the cases not being considered instead of hiding real bugs

I actually agree with the general sentiment, but,

Then you have to fix all the code which has assumed such, breaking
previously-correct code.  bcrl (IIRC) was the one who told me about
kfree doing the NULL check; likewise akpm for brelse.  So people are
using these things.

Do you really want to audit every single kfree and brelse to implement
this change?

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

