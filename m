Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154039-8316>; Tue, 8 Sep 1998 23:51:10 -0400
Received: from neon-best.transmeta.com ([206.184.214.10]:9049 "EHLO neon.transmeta.com" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <154865-8316>; Tue, 8 Sep 1998 18:26:14 -0400
To: linux-kernel@vger.rutgers.edu
From: hpa@transmeta.com (H. Peter Anvin)
Subject: Re: GPS Leap Second Scheduled!
Date: 9 Sep 1998 00:59:47 GMT
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <6t4ju3$gve$1@palladium.transmeta.com>
References: <299BBE59294E@rkdvmks1.ngate.uni-regensburg.de> <98090822315400.00819@soda>
Reply-To: hpa@transmeta.com (H. Peter Anvin)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 1998 H. Peter Anvin - All Rights Reserved
Sender: owner-linux-kernel@vger.rutgers.edu

Followup to:  <98090822315400.00819@soda>
By author:    Andrej Presern <andrejp@luz.fe.uni-lj.si>
In newsgroup: linux.dev.kernel
> 
> Have you considered simply not scheduling any processes for one second and
> adjusting the time accordingly? (if one second chunk is too big, you can do it
> in several steps)
> 
> Andrej
> 

The way xntp deals with leap seconds is it lets the epoch
float... i.e. it holds time_t to the same value for two seconds.  One
proposal (which I like) was to compensate for this by allowing the
microsecond or nanosecond fields or struct timeval & co to advance to
1,999,999 µs or 1,999,999,999 ns in the case of such events.  The neat
thing is that the latter number fits very nicely in a 32-bit integer
even if someone (mis-) interprets it as signed.

	-hpa

-- 
    PGP: 2047/2A960705 BA 03 D3 2C 14 A8 A8 BD  1E DF FE 69 EE 35 BD 74
    See http://www.zytor.com/~hpa/ for web page and full PGP public key
        I am Bahá'í -- ask me about it or see http://www.bahai.org/
   "To love another person is to see the face of God." -- Les Misérables

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html
