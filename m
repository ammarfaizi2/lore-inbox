Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274216AbRIXW02>; Mon, 24 Sep 2001 18:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274211AbRIXW0J>; Mon, 24 Sep 2001 18:26:09 -0400
Received: from [208.129.208.52] ([208.129.208.52]:9 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S274210AbRIXW0C>;
	Mon, 24 Sep 2001 18:26:02 -0400
Message-ID: <XFMail.20010924153017.davidel@xmailserver.org>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010924232123.B10253@kushida.jlokier.co.uk>
Date: Mon, 24 Sep 2001 15:30:17 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Subject: Re: [PATCH] /dev/epoll update ...
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 24-Sep-2001 Jamie Lokier wrote:
> Davide Libenzi wrote:
>> Sure you can avoid the scan, if you pick up one event at a time.  To
>> be compared to /dev/epoll you need the signal-per-fd patch plus a
>> method to collect the whole event-set in a single system call ( see
>> perfs ).
> 
> Yes, I agree.  A variant of sigwaitinfo that will return multiple queued
> signals was mentioned ages ago, but because the siginfo structure is
> much larger than is needed, that isn't a very effective use of cache.
> 
> Something specialised for fd events is more appropriate IMO.  Large
> numbers of queued RT signals aren't used for anything else AFAIK anyway,
> not even timers.

The bottom line is, for what i saw in my tests, that both /dev/epoll and
RT signals ( with signal-per-fd ) offers good performance and scalability.




- Davide

