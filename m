Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289139AbSBDRed>; Mon, 4 Feb 2002 12:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289140AbSBDRe0>; Mon, 4 Feb 2002 12:34:26 -0500
Received: from squeaker.ratbox.org ([63.216.218.7]:12295 "EHLO
	squeaker.ratbox.org") by vger.kernel.org with ESMTP
	id <S289136AbSBDReJ>; Mon, 4 Feb 2002 12:34:09 -0500
Date: Mon, 4 Feb 2002 12:41:05 -0500 (EST)
From: Aaron Sethman <androsyn@ratbox.org>
To: Darren Smith <data@barrysworld.com>
Cc: "'Andrew Morton'" <akpm@zip.com.au>, "'Dan Kegel'" <dank@kegel.com>,
        "'Vincent Sweeney'" <v.sweeney@barrysworld.com>,
        <linux-kernel@vger.kernel.org>, <coder-com@undernet.org>,
        "'Kevin L. Mitchell'" <klmitch@mit.edu>
Subject: RE: [Coder-Com] Re: PROBLEM: high system usage / poor SMP network
 performance
In-Reply-To: <000201c1ad8c$4fcc99c0$c2f0bcc3@wilma>
Message-ID: <Pine.LNX.4.44.0202041239310.4584-100000@simon.ratbox.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 4 Feb 2002, Darren Smith wrote:

> Hi
>
> I've been testing the modified Undernet (2.10.10) code with Vincent
> Sweeney based on the simple usleep(100000) addition to s_bsd.c
>
> PRI NICE  SIZE    RES STATE  C   TIME   WCPU    CPU | # USERS
>  2   0 96348K 96144K poll   0  29.0H 39.01% 39.01%  |  1700 <- Without
> Patch
> 10   0 77584K 77336K nanslp 0   7:08  5.71%  5.71%  |  1500 <- With
> Patch
Were you not putting a delay argument into poll(), or perhaps not letting
it delay long enough?  If you just do poll with a timeout of 0, its going
to suck lots of cpu.

Regards,

Aaron


