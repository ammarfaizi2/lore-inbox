Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUAYUXr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 15:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265243AbUAYUXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 15:23:46 -0500
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:59411 "EHLO
	smtp-out2.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S265224AbUAYUVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 15:21:53 -0500
Message-ID: <4014255F.9070006@blueyonder.co.uk>
Date: Sun, 25 Jan 2004 20:21:51 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040118
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc1-mm2 kernel oops
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Jan 2004 20:22:14.0372 (UTC) FILETIME=[EB8D2240:01C3E380]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Adrian Bunk wrote:
> On Sun, Jan 25, 2004 at 03:14:51PM +0000, Sid Boyce wrote:
>  >> Linus Torvalds wrote:
>  > > > Problems with the exception table sorting?
>  > > >
>  > > > Does plain 2.6.2-rc1 work?
>  >> 2.6.2-rc1 works fine.
> 
>  > Could you back out ("patch -p1 -R < ..." or manually remove the lines)
>  > the patch below and retry 2.6.2-rc1-mm2?
> 
> 
> 
>  > TIA
>  > Adrian
> 
> 
>  > --- 25/Makefile~use-funit-at-a-time 2004-01-14 00:56:05.000000000 -0800
>  > +++ 25-akpm/Makefile 2004-01-14 00:56:05.000000000 -0800
>  > @@ -445,6 +445,10 @@ ifdef CONFIG_DEBUG_INFO
>  > CFLAGS += -g
>  > endif
> 
>  > +# Enable unit-at-a-time mode when possible. It shrinks the
>  > +# kernel considerably.
>  > +CFLAGS += $(call check_gcc,-funit-at-a-time,)
>  > +
>  > # warn about C99 declaration after statement
>  > CFLAGS += $(call check_gcc,-Wdeclaration-after-statement,)

I commented out the line below. 2.6.2-rc1-mm3 is now up and running, 
thanks.

CFLAGS += $(call check_gcc,-funit-at-a-time,)

Regards
Sid.




-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.
