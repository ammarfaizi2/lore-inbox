Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284808AbRLPUaM>; Sun, 16 Dec 2001 15:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284809AbRLPUaC>; Sun, 16 Dec 2001 15:30:02 -0500
Received: from postfix2-1.free.fr ([213.228.0.9]:60617 "HELO
	postfix2-1.free.fr") by vger.kernel.org with SMTP
	id <S284808AbRLPU3o>; Sun, 16 Dec 2001 15:29:44 -0500
From: Willy Tarreau <wtarreau@free.fr>
Message-Id: <200112162029.fBGKTdq02390@ns.home.local>
Subject: Re: Timeouts on 3C575 network device
To: swsnyder@home.com
Date: Sun, 16 Dec 2001 21:29:38 +0100 (CET)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

I have the same problem here (3c575 too, K6-2 too). Cardbus bridge TI1251B.

But I noticed that it nearly never occurs when I put my notebook in a cold
room. Also, it occurs more often when I have transmitted lots of data and the
notebook is hot. In my case, I believe it comes from the cardbus bridge not
coping with the card speed. Perhaps under windows the card is underloaded and
the bridge can keep cool ? but I definitely think it's a hardware problem first
and perhaps the software can mask it.

If you want to reduce the penalty of these timeouts, you can put this line
in your /etc/modules.conf : "options 3c59x watchdog=50". It prevents the
card from hanging more than 50 ms. But take care of your syslog !

Regards,
Willy

