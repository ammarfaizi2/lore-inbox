Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136601AbRECJ6I>; Thu, 3 May 2001 05:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136595AbRECJ57>; Thu, 3 May 2001 05:57:59 -0400
Received: from smtp3.libero.it ([193.70.192.53]:27316 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S136560AbRECJ5u>;
	Thu, 3 May 2001 05:57:50 -0400
Message-ID: <3AF12B94.60083603@alsa-project.org>
Date: Thu, 03 May 2001 11:57:40 +0200
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: "David S. Miller" <davem@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: unsigned long ioremap()?
In-Reply-To: <3AF10E80.63727970@alsa-project.org>  <Pine.LNX.4.05.10105030852330.9438-100000@callisto.of.borg> <15089.979.650927.634060@pizda.ninka.net> <11718.988883128@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> abramo@alsa-project.org said:
> >  The problem I see is that with the former solution nothing prevents
> > from to do:
> 
> >       regs->reg2 = 13;
> 
> > That's indeed the reason to change ioremap prototype for 2.5.
> 
> An alternative is to add an fixed offset to the cookie before returning it,
> and subtract it again in {read,write}[bwl].

You understand that in this way you change a compile time warning in a
runtime error (conditioned to path reaching, not easy to interpret,
etc.)

IMO this is a far less effective debugging strategy.

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
