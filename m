Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318360AbSHKUpR>; Sun, 11 Aug 2002 16:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318361AbSHKUpR>; Sun, 11 Aug 2002 16:45:17 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:32004 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S318360AbSHKUpQ>; Sun, 11 Aug 2002 16:45:16 -0400
Date: Sun, 11 Aug 2002 21:49:01 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: steveb@unix.lancs.ac.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 IDE Partition Check issue (again)
Message-ID: <20020811204901.GA39920@compsoc.man.ac.uk>
References: <E17diPZ-0004bU-00@wing1.lancs.ac.uk> <1029095618.16216.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1029095618.16216.21.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Boards of Canada - Geogaddi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2002 at 08:53:38PM +0100, Alan Cox wrote:

> Try this
> --- drivers/ide/alim15x3.c~	2002-08-11 19:33:14.000000000 +0100
> +++ drivers/ide/alim15x3.c	2002-08-11 19:33:14.000000000 +0100
> @@ -810,7 +810,7 @@
>  
>  	/* Don't use LBA48 on ALi devices before rev 0xC4 */
>  
> -	if(m5229_revision < 0xC4)
> +	if(m5229_revision <= 0xC4)
>  		hwif->addressing = 1;

would be nice to change the comment too ;)

regards
john

-- 
"It is unbecoming for young men to utter maxims."
	- Aristotle
