Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285653AbRLGXSY>; Fri, 7 Dec 2001 18:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285655AbRLGXSF>; Fri, 7 Dec 2001 18:18:05 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:59662 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S285653AbRLGXR6>; Fri, 7 Dec 2001 18:17:58 -0500
Message-ID: <3C114E14.F6DC7937@delusion.de>
Date: Sat, 08 Dec 2001 00:17:40 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1-pre3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "David C. Hansen" <haveblue@us.ibm.com>
CC: Andrew Morton <akpm@zip.com.au>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: release() locking
In-Reply-To: <3C10D83E.81261D74@delusion.de> <3C10FDCF.D8E473A0@zip.com.au> <3C11394D.90101@us.ibm.com> <3C113D78.F324F1B9@delusion.de> <3C113FB1.2000AFF1@zip.com.au> <3C1147F2.4070103@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David C. Hansen" wrote:
> 
> Andrew Morton wrote:

> >Maybe so.  Can you identify the exact kernel version at which
> >the problem started?

Yes. I tried the entire 2.5.1-pre series:

-pre1 and -pre2 are fine.
-pre3 doesn't compile out of the box and with 3 trivial compile fixes to
      pc_keyb.c shows the problem.

So anything including and after -pre3 is broken wrt. locking.

> The release() functions patch went into pre3.  It looks like Jens' bio
> changes went into pre4.

Like I said before - it has nothing to do with Jens' bio stuff. Also the
fixes done by Andrew have nothing to do with it.
Moreover, if I back out the changes to pc_keyb.c, the problem goes away.

Regards,
Udo.
