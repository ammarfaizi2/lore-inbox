Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269811AbRHYXfC>; Sat, 25 Aug 2001 19:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269817AbRHYXew>; Sat, 25 Aug 2001 19:34:52 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:32689 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S269811AbRHYXei>;
	Sat, 25 Aug 2001 19:34:38 -0400
Date: Sun, 26 Aug 2001 01:34:42 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Message-ID: <20010826013442.C29129@cerebro.laendle>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Rik van Riel <riel@conectiva.com.br>,
	Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010825213536.D18523@cerebro.laendle> <E15al3g-0008Ev-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E15al3g-0008Ev-00@the-village.bc.nu>
X-Operating-System: Linux version 2.4.8-ac8 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2001 at 10:33:36PM +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > exactly this is a point: my disk can do 5mb/s with almost random seeks,
> > and linux indeed reads 5mb/s from it. but the userpsace process doing
> > read() only ever sees 2mb/s because the kernel throes away all the nice
> > pages.
> 
> Which means the VM in the relevant kernel is probably crap or your working
> set exceeds ram.

The relevant kernel is linux (all 2.4 versions I tested), and no, working
set exceeding ram should never result in such excessive thrashing. So yes,
the VM in the kernel is crap (in this particular case, namely high-volume
fileserving) ;)

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
