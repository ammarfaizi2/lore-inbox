Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280837AbRKGQKa>; Wed, 7 Nov 2001 11:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280834AbRKGQKU>; Wed, 7 Nov 2001 11:10:20 -0500
Received: from news.cistron.nl ([195.64.68.38]:58116 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S280830AbRKGQKG>;
	Wed, 7 Nov 2001 11:10:06 -0500
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: "ps ax" shows init [
Date: Wed, 7 Nov 2001 16:10:04 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9sbmcs$t4t$1@ncc1701.cistron.net>
In-Reply-To: <Pine.LNX.4.10.10111071747430.31120-100000@ares.sot.com>
X-Trace: ncc1701.cistron.net 1005149404 29853 195.64.65.67 (7 Nov 2001 16:10:04 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.10.10111071747430.31120-100000@ares.sot.com>,
Yaroslav Popovitch  <yp@sot.com> wrote:
>doing "ps ax" get such msg for kernel-2.4.9:
>That is the same for kernel-2.4.12.Sometimes it is shown as it should be.
>Is this a bug of kernel? It seems to be..
>
>  PID TTY      STAT   TIME COMMAND
>    1 ?        S      0:06 init [    

It's because init doesn't have enough space in argv[] to change it's
process title. There are a number of causes for this, one indirect
one is pressing 'enter' at the 'LILO boot: ' prompt.

Mike.
-- 
"Only two things are infinite, the universe and human stupidity,
 and I'm not sure about the former" -- Albert Einstein.

