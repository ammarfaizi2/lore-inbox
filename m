Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283860AbRLRE2b>; Mon, 17 Dec 2001 23:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284038AbRLRE2W>; Mon, 17 Dec 2001 23:28:22 -0500
Received: from mx2.port.ru ([194.67.57.12]:38151 "EHLO smtp2.port.ru")
	by vger.kernel.org with ESMTP id <S284017AbRLRE2Q>;
	Mon, 17 Dec 2001 23:28:16 -0500
Date: Tue, 18 Dec 2001 07:26:56 +0300
From: Dmitry Volkoff <vdb@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: Unfreeable buffer/cache problem in 2.4.17-rc1 still there
Message-ID: <20011218072656.D1841@localhost>
In-Reply-To: <20011216223909.A230@localhost> <01121715011208.02146@manta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01121715011208.02146@manta>; from vda@port.imtp.ilyichevsk.odessa.ua on Mon, Dec 17, 2001 at 03:01:12PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 03:01:12PM -0200, vda wrote:
> >     if (r == -1) {
> >       printf("unable to write\n");
> >       close(fd);
> >       return;
> >     }
> >     close(fd);
> >     sleep(1);
> >   }
> > }
> > // end test.c
> 
> I removed sleep(1). Is it needed?
>

Yes, you need it in order to see the memory leakage.
 
> After 10000+ runs of this proggy swap usage isn't changed on 2.4.17-pre7.
> top reports constant 2304K of swap usage.

I know. You'll notice this effect only after 1000000+ runs.
Try it again with sleep(1).

> --
> vda
> 

-- 

    DV
