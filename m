Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263669AbRFKT4c>; Mon, 11 Jun 2001 15:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263825AbRFKT4M>; Mon, 11 Jun 2001 15:56:12 -0400
Received: from [205.178.14.190] ([205.178.14.190]:13835 "EHLO
	orca.desanasystems.com") by vger.kernel.org with ESMTP
	id <S263669AbRFKT4D>; Mon, 11 Jun 2001 15:56:03 -0400
Message-ID: <1DF71FB881F4D311A6B700C04FA06A1AC43597@orca.desanasystems.com>
From: "Marti, Felix" <fmarti@desanasystems.com>
To: "'Troy Benjegerdes'" <hozer@drgw.net>,
        Zehetbauer Thomas <TZ@link.topcall.co.at>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: IBM PPC 405 series little endian?
Date: Mon, 11 Jun 2001 12:53:07 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know why you want to run the 405 in LE... but one feature that comes
in handy for me is mapping pages as LE, even though the CPU is running in
BE... this might be what you're looking for.

felix

-----Original Message-----
From: Troy Benjegerdes [mailto:hozer@drgw.net]
Sent: Monday, June 11, 2001 11:40 AM
To: Zehetbauer Thomas
Cc: 'linux-kernel@vger.kernel.org'
Subject: Re: IBM PPC 405 series little endian?


On Mon, Jun 11, 2001 at 01:34:21PM +0200, Zehetbauer Thomas wrote:
> Has someone experimented with running linux in little-endian mode on IBM
> PowerPC 405 (Walnut) yet?

Well, first, I have to ask, why??

First, if you need to deal with little endian data, on a PPC stwbrx &
lwbrx are your friends.

With the possible exception of the matrox guy, I haven't heard of ANYONE 
running in LE mode on ppc. The second problem is going to be to recompile 
ALL the applications you want and hope they work.

Finally, if you're doing anything that connects to the internet, remember 
that network byte order is big-endian. You might find it interesting that 
even Intel is now re-discovering the usefullness of big-endian in some of 
their strongarm/Xscale processors.

--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Shulz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
