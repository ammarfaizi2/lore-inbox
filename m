Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131958AbRDJTml>; Tue, 10 Apr 2001 15:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131974AbRDJTma>; Tue, 10 Apr 2001 15:42:30 -0400
Received: from aragorn.ics.muni.cz ([147.251.4.33]:49312 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S131958AbRDJTmO>; Tue, 10 Apr 2001 15:42:14 -0400
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@i.am>
Subject: Re: No 100 HZ timer !
Message-ID: <3AD3620F.85BB9B11@i.am>
Date: Tue, 10 Apr 2001 19:42:07 GMT
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Nntp-Posting-Host: dual.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: cs, en
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E14n1vV-0004gX-00@the-village.bc.nu>
Mime-Version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-RTL3.0 i686)
Organization: unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Games would like to be able to page flip at vertical refresh time --
> > <1ms accuracy please.  Network traffic shaping benefits from better than
> 
> This is an X issue. I was talking with Jim Gettys about what is needed to
> get the relevant existing X extensions for this working

I've already proposed my /dev/vbi device (currently works only for MGA
card)
- read returns when VBI occures - works quite well...
(currently in avifile CVS tree)

Anyway in good all days AmigaOS had interrupt service where devices
where sending timer request - they were queued and timer device was
serving
them in order - I don't see the reason why we should implement this
differently.
If there is no real reason to interrupt system more then 100Hz
periodicity
then this is ok - scheduler will simple send time request for
rescheduling in 10ms.

Why we should create 1KHz timers or so when this way seems to be much
more
elegant and will work even on XXGHz systems.


bye

kabi@i.am

