Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316127AbSFETLR>; Wed, 5 Jun 2002 15:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316158AbSFETLQ>; Wed, 5 Jun 2002 15:11:16 -0400
Received: from relay03.valueweb.net ([216.219.253.237]:57610 "EHLO
	relay03.valueweb.net") by vger.kernel.org with ESMTP
	id <S316127AbSFETLO>; Wed, 5 Jun 2002 15:11:14 -0400
Message-ID: <3CFE625B.AB445C6C@opersys.com>
Date: Wed, 05 Jun 2002 15:11:23 -0400
From: Karim Yaghmour <karim@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Paul Zimmerman <Paul_Zimmerman@inSilicon.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
In-Reply-To: <7FD8B823E5024E44B027221DEB34C087536524@scl-exch.phoenix.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul Zimmerman wrote:
> What if I'm unfortunate enough to have my sound card share an interrupt
> with my IDE controller? Won't my realtime audio player still be at the
> mercy of my non-realtime Linux IDE driver? Or does Adeos have a way to
> handle that?

That's an interesting case. There is nothing against the RTOS and
Linux both asking the ipipe to signal them if this interrupt occurs.
The RTOS would get it first, decide whether its the sound card and do
whatever it needs to do with it. Whether it needs it or not, it doesn't
terminate the interrupt so the interrupts makes its way through the ipipe
and ends up somewhere afterwards in Linux's hands which can then deal
with it as it sees fit.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
