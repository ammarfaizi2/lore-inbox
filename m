Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275843AbRJBGuT>; Tue, 2 Oct 2001 02:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275841AbRJBGuJ>; Tue, 2 Oct 2001 02:50:09 -0400
Received: from fw.sthlm.cendio.se ([213.212.13.67]:65264 "EHLO
	jarlsberg.sthlm.cendio.se") by vger.kernel.org with ESMTP
	id <S275843AbRJBGtx>; Tue, 2 Oct 2001 02:49:53 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.LNX.4.33.0110012305350.3280-200000@localhost.localdomain>
From: Marcus Sundberg <marcus@cendio.se>
Date: 02 Oct 2001 08:50:19 +0200
In-Reply-To: <Pine.LNX.4.33.0110012305350.3280-200000@localhost.localdomain>
Message-ID: <ve8zeuy1qs.fsf@inigo.sthlm.cendio.se>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mingo@elte.hu (Ingo Molnar) writes:

> (note that in case of shared interrupts, another 'innocent' device might
> stay disabled for some short amount of time as well - but this is not an
> issue because this mitigation does not make that device inoperable, it
> just delays its interrupt by up to 10 msecs. Plus, modern systems have
> properly distributed interrupts.)

Guess my P3-based laptop doesn't count as modern then:

  0:    7602983          XT-PIC  timer
  1:      10575          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
 11:    1626004          XT-PIC  Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support, Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (#2), usb-uhci, eth0, BreezeCom Card, Intel 440MX, irda0
 12:       1342          XT-PIC  PS/2 Mouse
 14:      23605          XT-PIC  ide0

I can't even imagine why they did it like this...

//Marcus
-- 
---------------------------------+---------------------------------
         Marcus Sundberg         |      Phone: +46 707 452062
   Embedded Systems Consultant   |     Email: marcus@cendio.se
        Cendio Systems AB        |      http://www.cendio.com
