Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271895AbRH1TpS>; Tue, 28 Aug 2001 15:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271896AbRH1To7>; Tue, 28 Aug 2001 15:44:59 -0400
Received: from h157s242a129n47.user.nortelnetworks.com ([47.129.242.157]:20670
	"EHLO zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S271895AbRH1Tox>; Tue, 28 Aug 2001 15:44:53 -0400
Message-ID: <3B865DCB.C60525B@nortelnetworks.com>
Date: Fri, 24 Aug 2001 09:59:39 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (comments requested) adding finer-grained timing to PPC 
         add_timer_randomness()
In-Reply-To: <Pine.LNX.4.21.0108240856370.1353-100000@ltgp.iram.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Paubert wrote:

> No, both the RTC and the decrementer count nanoseconds, except that the 7
> LSB are not implemented because the timebase clock should have a period of
> 128 ns (7.8125 MHz, but according to Takashi Oe, many 601 systems did not
> bother to provide the exact frequency and are off by 11 parts in 4096 or
> so). As such the LSB can't be used to estimate randomness and the value
> must be shifted right by 7. So you need some conditional code (or boot
> time patching). At this point you can throw in the high order part
> (RTCU/TBU) for additional randomization (RTCU changes much faster on 601,
> once per second, than on the other processors).

Have you got any links to information on boot time patching?


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
