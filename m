Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270988AbRHYTgH>; Sat, 25 Aug 2001 15:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271054AbRHYTf7>; Sat, 25 Aug 2001 15:35:59 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:51120 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S270988AbRHYTfn>;
	Sat, 25 Aug 2001 15:35:43 -0400
Date: Sat, 25 Aug 2001 21:35:36 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Message-ID: <20010825213536.D18523@cerebro.laendle>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Rik van Riel <riel@conectiva.com.br>,
	Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010825163648Z16186-32383+1334@humbolt.nl.linux.org> <E15aiuG-000821-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E15aiuG-000821-00@the-village.bc.nu>
X-Operating-System: Linux version 2.4.8-ac8 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2001 at 08:15:44PM +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> How much disk and bandwidth can you afford. With vsftpd its certainly over
> 1000 parallal downloads on a decent PII box

exactly this is a point: my disk can do 5mb/s with almost random seeks,
and linux indeed reads 5mb/s from it. but the userpsace process doing
read() only ever sees 2mb/s because the kernel throes away all the nice
pages.

I doubt vsftpd would help at all.

(one can easily get 2000 or more parallel downloads, if you are willing to
go with 1kb/s).

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
