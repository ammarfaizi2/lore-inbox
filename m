Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130900AbRDSQTv>; Thu, 19 Apr 2001 12:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130820AbRDSQTl>; Thu, 19 Apr 2001 12:19:41 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:32950 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S131275AbRDSQT1>; Thu, 19 Apr 2001 12:19:27 -0400
Message-ID: <3ADF1003.871E4A66@coplanar.net>
Date: Thu, 19 Apr 2001 12:19:15 -0400
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Praveen Rajendran <rp@sasken.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux timer performance ?
In-Reply-To: <3ADF4D47.7B9B5EFD@sasken.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Praveen Rajendran wrote:

> hi
>
> I am working on a kernel module which requires the addition of a large
> number of kernel timers  to expire statistical values ( including time
> ) maintained in a table.
>
> One alternative would be to use a single timer and traverse the entire
> table and use the existing system time to expire the values ( comparing
> it with the time already stored in the table )when the timer expires .

Most versions of cron claim to be very scalable, and use an optimized
algorithm to do the second option.  (avoiding linear scan) You could likely
just cut and paste
the code.  Problem solved?

>
>
> Following the method I describe first I would have to add a large number
> of timers ( around 2000) ... would this cause any significant
> performance drop  ? which method should I use ?
>
> thanks in advance
>
> Praveen
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

