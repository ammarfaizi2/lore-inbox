Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291012AbSAaS5u>; Thu, 31 Jan 2002 13:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291014AbSAaS5k>; Thu, 31 Jan 2002 13:57:40 -0500
Received: from beasley.gator.com ([63.197.87.202]:29194 "EHLO
	beasley.gator.com") by vger.kernel.org with ESMTP
	id <S291012AbSAaS5a>; Thu, 31 Jan 2002 13:57:30 -0500
From: "George Bonser" <george@gator.com>
To: "Deepinder Singh" <dsingh@somanetworks.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: Memory leaks with GRE Tunnels 
Date: Thu, 31 Jan 2002 10:57:28 -0800
Message-ID: <CHEKKPICCNOGICGMDODJKEHPGDAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <3C598DE3.8090405@somanetworks.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if this also causes a different problem ... when using CIPE
(which is a tunnel of a different sort) if I stop a tunnel, I can not
restart it with the same cipe device number. I get a message that the
device is in use.  I have to unload and reload the CIPE module to be
able to use the device numbers configured in the config file. If I
increment the device each time (e.g. cipcb0, then cipcb1, cipcb2) I
restart the tunnel, it works.  I wonder if it is something in the way
Linux handles tunnel interfaces in the generic sense and not just
limited to GRE.

By the way, this behavior is on 2.2 kernels, I have no CIPE units
running 2.4 and you did not mention which kernel version you are
using.


> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of
> Deepinder Singh
> Sent: Thursday, January 31, 2002 10:33 AM
> To: linux-kernel@vger.kernel.org
> Subject: Memory leaks with GRE Tunnels
>
>
> Hi ,
>
> I have been doing some testing using GRE tunnels in Linux (
> which btw
> work great ). I found that creating and deleting a tunnel
> results in a
> memory leak.
>
> To test it out I wrote a small script that basically loops around
> creating and then deleting 8000 tunnel interfaces at a time. On the
> eighth iteration  the system hangs a whole with no error
> messages. There
>   was still enoungh virtual memory around even with the leaks so I
> figured something else is wrong. It turns out that the
> interface numbers
> ( as seen in ' ip link ls' )  do not seem to be reused when
> an interface
> is deleted and as such the system hangs when the number reaches 64K.
>
> I suspect the two issues are realted but am more of a cisco
> guy and know
> kernel internals. The total mem leak for the 64 K tunnels
> is about 200 megs.
>
> Please cc me if you reply to this post as I am not on the list.
>
> thanks,
> Deepinder Singh
> Sr. Network Eng.
> Soma Networks
>
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

