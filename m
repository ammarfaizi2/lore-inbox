Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312975AbSC0Dw2>; Tue, 26 Mar 2002 22:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312976AbSC0DwS>; Tue, 26 Mar 2002 22:52:18 -0500
Received: from web21208.mail.yahoo.com ([216.136.175.166]:37257 "HELO
	web21208.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S312975AbSC0DwG>; Tue, 26 Mar 2002 22:52:06 -0500
Message-ID: <20020327035205.57964.qmail@web21208.mail.yahoo.com>
Date: Tue, 26 Mar 2002 19:52:05 -0800 (PST)
From: Melkor Ainur <melkorainur@yahoo.com>
Subject: Re: signal_pending() and schedule()
To: Joel Becker <Joel.Becker@oracle.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020327014932.GB803@insight.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel, everyone,

Thanks for the info about the SIGALRM. I had not 
noticed this until I did an strace on netscape. 

I had been simple minded in my implementation of
tcp_sendmsg. For a userspace application such as 
netscape, I allocate a kernel buffer(s)and copy the 
data from user space into this/these buffer(s) 
(because I am unaware of a way around singlecopy
when the app uses a userspace buffer). I then schedule
dma. After that I put the calling application to
sleep. I don't have a good idea of how I would
handle this if the application got woken up out of the
sleep by a signal before the dma was done. I suppose
I could spin but that seems unclean. I will 
look through other drivers and see if/how this is
handled but any leads would be greatly appreciated.

                                        Thanks,
                                        Melkor

--- Joel Becker <Joel.Becker@oracle.com> wrote:
> A signal has arrived.  Netscape's userspace
> "threading" is based
> entirely on signals.  Netscape sends itself SIGALRM
> almost continuously.
> You'll have to expect this from Netscape and work
> around or with it.
> 
> Joel
> 


__________________________________________________
Do You Yahoo!?
Yahoo! Movies - coverage of the 74th Academy Awards®
http://movies.yahoo.com/
