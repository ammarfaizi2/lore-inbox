Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263326AbSJOQzO>; Tue, 15 Oct 2002 12:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264657AbSJOQzO>; Tue, 15 Oct 2002 12:55:14 -0400
Received: from relay1.pair.com ([209.68.1.20]:4621 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S263326AbSJOQyd>;
	Tue, 15 Oct 2002 12:54:33 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3DAC4B0E.EBB3A2AB@kegel.com>
Date: Tue, 15 Oct 2002 10:06:22 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
References: <3DAB46FD.9010405@watson.ibm.com> <20021015110501.B11395@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> 
> On Mon, Oct 14, 2002 at 06:36:45PM -0400, Shailabh Nagar wrote:
> > As of today, there is no scalable alternative to poll/select in the 2.5
> > kernel even though the topic has been discussed a number of times
> > before. The case for a scalable poll has been made often so I won't
> > get into that.
> 
> Have you bothered addressing the fact that async poll scales worse than
> /dev/epoll?  That was the original reason for dropping it.

Doesn't the F_SETSIG/F_SETOWN/SIGIO stuff qualify as a scalable
alternative?
It's in 2.5 as far as I know.   It does suffer from using the signal
queue,
but it's in production use on servers that handle many thousands of 
concurrent connections, so it's pretty scalable.

- Dan
