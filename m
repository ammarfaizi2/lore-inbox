Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262560AbRE3Brz>; Tue, 29 May 2001 21:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262561AbRE3Brp>; Tue, 29 May 2001 21:47:45 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:55533 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262560AbRE3Brb>;
	Tue, 29 May 2001 21:47:31 -0400
Message-ID: <3B145127.5B173DFF@mandrakesoft.com>
Date: Tue, 29 May 2001 21:47:19 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jt@hpl.hp.com
Cc: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, tori@unhappy.mine.nu,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net #9
In-Reply-To: <200105300048.CAA04583@green.mif.pg.gda.pl> <20010529180420.A14639@bougret.hpl.hp.com> <3B14493E.63F861E7@mandrakesoft.com> <20010529182506.A14727@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> 
> On Tue, May 29, 2001 at 09:13:34PM -0400, Jeff Garzik wrote:
> >
> > This is standard kernel cleanup that makes the resulting image smaller.
> > These patches have been going into all areas of the kernel for quite
> > some time.
> 
>         This doesn't make it right.
> 
>         Ok, while we are on the topic : could somebody explain me why
> we can't get gcc to do that for us ? What is preventing adding a gcc
> command line flag to do exactly that ? It's not like rocket science
> (simple test) and would avoid to have tediously to go through all
> source code, past, present and *future* to make those changes.
>         Bah, maybe it's too straightforward...

This is ANSI C standard stuff.  If a static object with a scalar type is
not explicitly initialized, it is initialized to zero by default.

Sure we can get gcc to recognize that case, but why use gcc to work
around code that avoids an ANSI feature?

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
