Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129086AbRBANyn>; Thu, 1 Feb 2001 08:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129053AbRBANye>; Thu, 1 Feb 2001 08:54:34 -0500
Received: from smtp.mountain.net ([198.77.1.35]:60169 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S129086AbRBANyV>;
	Thu, 1 Feb 2001 08:54:21 -0500
Message-ID: <3A796A77.3B1D3DE4@mountain.net>
Date: Thu, 01 Feb 2001 08:53:59 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: David Ford <david@linux.com>, Stephen Frost <sfrost@snowman.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x and SMP fails to compile (`current' undefined)
In-Reply-To: <E14OHKN-00047W-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> We have a very large number of memcpy's of unknown short length (often in
> interrupts) that are close to branches. A lot of
> 
>         if(foo==NULL)
>                 return
>         memcpy(..
> 
> stuff for example.
> 
> Im more than happy for someone to do the benches and prove me wrong

Agreed, that is a bad case, and there is overhead for it in my patch. I'm
putting together some metrics, will post results here.

Regards,
Tom

-- 
The Daemons lurk and are dumb. -- Emerson
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
