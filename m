Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271828AbRH0SYM>; Mon, 27 Aug 2001 14:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271827AbRH0SYC>; Mon, 27 Aug 2001 14:24:02 -0400
Received: from burdell.cc.gatech.edu ([130.207.3.207]:49925 "EHLO
	burdell.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S271828AbRH0SX6>; Mon, 27 Aug 2001 14:23:58 -0400
Message-ID: <3B8A9042.4027049@cc.gatech.edu>
Date: Mon, 27 Aug 2001 14:24:02 -0400
From: Josh Fryman <fryman@cc.gatech.edu>
Organization: CoC, GaTech
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: silly memory question ...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi all,

i'm looking to do something stupid.  can anyone tell me why it won't
work? (is there some kind of special protection on EXE memory pages?)

i have an application, App1, that has a 64KB function (64KB of NOP)
"void funcX(void)".  App1 opens a socket to another application, App2,
which is going to feed code to App1 to stick in funcX.

that is, i've got some other set of functions i plan on feeding to App1
and they're all going to look like "funcX" to App1.  those functions are
coming from App2, which is chewing on a bunch of var-things to spit out 
just the right code for App1.

now, when i try to do this, i get Random Stuff.  sometimes, i just get
a segfault.  sometimes, it seems to work, but the memory at funcX is
hosed if i do a hex-dump compared to what i received from App2.  either
way, it isn't doing what i want...

is there some trick here to make this work?  or am i SOL?

[is there a better place to ask this question?]

thanks,

josh
