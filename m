Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130846AbRAaAJn>; Tue, 30 Jan 2001 19:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130993AbRAaAJf>; Tue, 30 Jan 2001 19:09:35 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:40175 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S130846AbRAaAJ2>; Tue, 30 Jan 2001 19:09:28 -0500
Date: Tue, 30 Jan 2001 18:09:26 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <3A7756F0.8B589FC7@innominate.de>
In-Reply-To: <Pine.LNX.4.21.0101291018080.5353-100000@ns-01.hislinuxbox.com> 
	<Pine.LNX.4.21.0101291018080.5353-100000@ns-01.hislinuxbox.com> 
	<Mdiqd.A.qe.yEvd6@dinero.interactivesi.com>
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-ID: <27QDuD.A.1CC.2e1d6@dinero.interactivesi.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Daniel Phillips <phillips@innominate.de> on Wed, 31
Jan 2001 01:06:08 +0100


> > What is wrong with sleep_on()?
> 
> If you have a task that looks like:
> 
>     loop:
>         <do something important>
>         sleep_on(q)
> 
> And you do wakeup(q) hoping to get something important done, then if the
> task isn't sleeping at the time of the wakeup it will ignore the wakeup
> and go to sleep, which imay not be what you wanted.

Ok, so how should this code have been written?


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
