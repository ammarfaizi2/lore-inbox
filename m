Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261325AbRETCEF>; Sat, 19 May 2001 22:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbRETCDy>; Sat, 19 May 2001 22:03:54 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:9735 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261325AbRETCDu>;
	Sat, 19 May 2001 22:03:50 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.4-ac11 network drivers cleaning 
In-Reply-To: Your message of "Sat, 19 May 2001 17:58:49 -0400."
             <3B06EC99.B23A1F8@mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 20 May 2001 12:03:42 +1000
Message-ID: <12098.990324222@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 May 2001 17:58:49 -0400, 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>Finally, I don't know if I mentioned this earlier, but to be complete
>and optimal, version strings should be a single variable 'version', such
>that it can be passed directly to printk like
>
>	printk(version);

Nit pick.  That has random side effects if version contains any '%'
characters.  Make it

	printk("%s\n", version);

Not quite as optimal but safer.

