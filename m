Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267429AbRGLFFF>; Thu, 12 Jul 2001 01:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267430AbRGLFEy>; Thu, 12 Jul 2001 01:04:54 -0400
Received: from sncgw.nai.com ([161.69.248.229]:4287 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S267429AbRGLFEu>;
	Thu, 12 Jul 2001 01:04:50 -0400
Message-ID: <XFMail.20010711220804.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3B4CF1BB.138FB64B@kegel.com>
Date: Wed, 11 Jul 2001 22:08:04 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Dan Kegel <dank@kegel.com>
Subject: Re: Improving (network) IO performance ...
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12-Jul-2001 Dan Kegel wrote:
> Very cool.  Thanks for doing a no-scan implementation of /dev/poll!
> Two questions:
> 
> 1) have you compared its performance against Vitaly Luban's 
> signal-per-fd patch?  Even though it's realtime-signal based,
> there's some hope for it being quite efficient.  See
> http://www.luban.org/GPL/gpl.html and
> http://boudicca.tux.org/hypermail/linux-kernel/2001week20/1353.html

There's more than the event collapsing inside the patch.
I saw the Luban's work but I decided to use the Lever-Provos /dev/poll as a
performance meter ( and the old poll() obviously ).
This coz I read papers where RT signals implementations resulted to have less
performance when compared to /dev/poll.


> 2) A little birdie told me that someone had gotten a freebsd
> box to handle something like half a million connections.
> I would like to see you extend the horizontal axis of your graph
> by a couple orders of magnitude :-)

Here You can find the new statistics with 16000 connections :

http://www.xmailserver.org/linux-patches/nio-improve.html

I cannot reach that number of connections of the test machine coz the socket
buffer space will eat all my memory ( 128 Mb ).
Anyway the graph speaks quite clear about the tendency to greater numbers of
connections.


> p.s. I have updated http://www.kegel.com/c10k.html#nb./dev/poll
> with a link to your report.

Thanks, the page is a work in progress anyway.




- Davide

