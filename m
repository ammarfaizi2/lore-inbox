Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284732AbSBDSX6>; Mon, 4 Feb 2002 13:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286893AbSBDSXt>; Mon, 4 Feb 2002 13:23:49 -0500
Received: from squeaker.ratbox.org ([63.216.218.7]:25607 "EHLO
	squeaker.ratbox.org") by vger.kernel.org with ESMTP
	id <S284732AbSBDSXg>; Mon, 4 Feb 2002 13:23:36 -0500
Date: Mon, 4 Feb 2002 13:30:40 -0500 (EST)
From: Aaron Sethman <androsyn@ratbox.org>
To: Darren Smith <data@barrysworld.com>
Cc: "'Andrew Morton'" <akpm@zip.com.au>, "'Dan Kegel'" <dank@kegel.com>,
        "'Vincent Sweeney'" <v.sweeney@barrysworld.com>,
        <linux-kernel@vger.kernel.org>, <coder-com@undernet.org>,
        "'Kevin L. Mitchell'" <klmitch@mit.edu>
Subject: RE: [Coder-Com] Re: PROBLEM: high system usage / poor SMP network
 performance
In-Reply-To: <000001c1ada7$5ad5cfb0$5c5a1e3e@wilma>
Message-ID: <Pine.LNX.4.44.0202041327420.4584-100000@simon.ratbox.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2002, Darren Smith wrote:

> I mean I added a usleep() before the poll in s_bsd.c for the undernet
> 2.10.10 code.
>
>  timeout = (IRCD_MIN(delay2, delay)) * 1000;
>  + usleep(100000); <- New Line
>  nfds = poll(poll_fds, pfd_count, timeout);
Why not just add the additional delay into the poll() timeout?  It just
seems like you were not doing enough of a delay in poll().

Regards,

Aaron

