Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130937AbRBHB17>; Wed, 7 Feb 2001 20:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130939AbRBHB1t>; Wed, 7 Feb 2001 20:27:49 -0500
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:21701 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S130937AbRBHB1b>; Wed, 7 Feb 2001 20:27:31 -0500
Message-ID: <3A81F60C.7C1DB09A@alumni.caltech.edu>
Date: Wed, 07 Feb 2001 17:27:40 -0800
From: Dan Kegel <dank@alumni.caltech.edu>
Reply-To: dank@alumni.caltech.edu
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dot@dotat.at
Subject: Re: TCP_NOPUSH on FreeBSD, TCP_CORK on Linux (was: Is sendfile all that
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexy wrote:

> > > How close is TCP_NOPUSH to behaving identically to TCP_CORK now? 
> 
> They have not so much of common. 
> 
> TCP_NOPUSH enables T/TCP and its presense used to mean that 
> T/TCP is possible on this system. Linux headers cannot 
> even contain TCP_NOPUSH.

But Tony Finch wrote:
> They are exactly the same. 

Alexy, Tony just checked in a change to FreeBSD to make TCP_NOPUSH behave the
same as TCP_CORK.

Tony, are people using the TCP_NOPUSH define as a way to detect
the presence of T/TCP support?  In that case, perhaps the right
thing to do to achieve source compatibility would be for FreeBSD
to also define TCP_CORK (and give it TCP_NOPUSH as a value, perhaps).

- Dan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
