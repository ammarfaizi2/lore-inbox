Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262126AbREXQBR>; Thu, 24 May 2001 12:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262127AbREXQBH>; Thu, 24 May 2001 12:01:07 -0400
Received: from geos.coastside.net ([207.213.212.4]:47019 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S262126AbREXQA5>; Thu, 24 May 2001 12:00:57 -0400
Mime-Version: 1.0
Message-Id: <p05100304b732e04cf9aa@[207.213.214.37]>
In-Reply-To: <E152w81-00053C-00@the-village.bc.nu>
In-Reply-To: <E152w81-00053C-00@the-village.bc.nu>
Date: Thu, 24 May 2001 09:00:20 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        tori@unhappy.mine.nu (Tobias Ringstrom)
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [PATCH] drivers/net/others
Cc: ankry@green.mif.pg.gda.pl (Andrzej Krzysztofowicz),
        jgarzik@mandrakesoft.com (Jeff Garzik), akpm@uow.edu.au,
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (kernel list)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 3:30 PM +0100 2001-05-24, Alan Cox wrote:
>  > > -		printk(version);
>>  > +		printk("%s", version);
>>  >
>>  Could you please explain the purpose of this change?  To me it looks less
>>  efficient in both performance and memory usage.
>
>its called 'programming in C not taking ugly shortcuts'
>>

Fine. But:

At 3:02 AM +0200 2001-05-24, Andrzej Krzysztofowicz wrote:
>-	printk(version);
>+#ifdef MODULE
>+	printk("s", version);
>  	printed_version = 1;
>+#endif /* MODULE */

...is playing it just a little too safe, wouldn't you say?

I assume that MODULE ifdef is related to version being initdata otherwise?
-- 
/Jonathan Lundell.
