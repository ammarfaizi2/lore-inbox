Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261812AbRE2AAL>; Mon, 28 May 2001 20:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261823AbRE2AAB>; Mon, 28 May 2001 20:00:01 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:43789 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261812AbRE1X7t>;
	Mon, 28 May 2001 19:59:49 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Bill Pringlemeir <bpringle@sympatico.ca>
cc: John Lenton <jlenton@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: how to crash 2.4.4 w/SBLive 
In-Reply-To: Your message of "28 May 2001 19:38:59 -0400."
             <m27kz111t8.fsf@sympatico.ca> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 29 May 2001 09:59:43 +1000
Message-ID: <4481.991094383@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 May 2001 19:38:59 -0400, 
Bill Pringlemeir <bpringle@sympatico.ca> wrote:
>ps, There is no FAQ entry on how to generate a single object with `-g'.  I
>ended up recompiling my whole tree!

I would say "read the source, Luke" but Makefile and Rules.make is so
convoluted and twisted that it gives you a headache following the rule
interactions.  Edit drivers/sound/emu10k1/Makefile

CFLAGS_timer.o += -g	 for one file or
EXTRA_CFLAGS += -g	 for all files in the directory.

With the 2.5 makefile rewrite you will be able to do

make EXTRA_CFLAGS_drivers/sound/emu10k1.o=-g	 for just one file or
make EXTRA_CFLAGS_drivers/sound=-g		 for all files in directory.

No need to edit the Makefiles to set temporary flags, althought you can
if you wish.

