Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261334AbRETCW1>; Sat, 19 May 2001 22:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261375AbRETCWR>; Sat, 19 May 2001 22:22:17 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:27309 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S261334AbRETCWH>;
	Sat, 19 May 2001 22:22:07 -0400
Message-ID: <3B072A49.B44B0F2A@mandrakesoft.com>
Date: Sat, 19 May 2001 22:22:01 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
Cc: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.4-ac11 network drivers cleaning
In-Reply-To: <12098.990324222@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Sat, 19 May 2001 17:58:49 -0400,
> Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> >Finally, I don't know if I mentioned this earlier, but to be complete
> >and optimal, version strings should be a single variable 'version', such
> >that it can be passed directly to printk like
> >
> >       printk(version);
> 
> Nit pick.  That has random side effects if version contains any '%'
> characters.  Make it
> 
>         printk("%s\n", version);
> 
> Not quite as optimal but safer.

I disagree.   Don't work around an escape bug in a version string, fix
it...

-- 
Jeff Garzik      | "Do you have to make light of everything?!"
Building 1024    | "I'm extremely serious about nailing your
MandrakeSoft     |  step-daughter, but other than that, yes."
