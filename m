Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267333AbTBISPM>; Sun, 9 Feb 2003 13:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267408AbTBISPM>; Sun, 9 Feb 2003 13:15:12 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:23427 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S267333AbTBISPL>;
	Sun, 9 Feb 2003 13:15:11 -0500
Date: Sun, 9 Feb 2003 21:22:51 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-pre4 comparison bugs (Even More Again)
Message-ID: <20030209182251.GA21226@linuxhacker.ru>
References: <20030208171838.GA2230@linuxhacker.ru> <1044752320.18908.18.camel@irongate.swansea.linux.org.uk> <20030209175349.GA20635@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030209175349.GA20635@linuxhacker.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

    Ok. In addition to "unsigned_var < 0" kind of error checks that
    never work, there is different non-working kind of checks:
    "pointer < 0".
    We can see these at:
drivers/char/joystick/tmdc.c:318	if (tmdc->abs[i] < 0) continue;
drivers/char/epca.c:3758		if (board.port <= 0)
drivers/char/epca.c:3770		if (board.membase <= 0)
drivers/media/radio/radio-cadet.c:541	if(request_region(io,2, "cadet-probe")>=0) {
drivers/net/wan/dscc4.c:1760		if (dscc4_init_dummy_skb(dpriv) < 0)

     Given the fact that you seem not to like casts to signed int,
     how do you propose to fix these?

Bye,
    Oleg
