Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287838AbSATBUB>; Sat, 19 Jan 2002 20:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287833AbSATBTw>; Sat, 19 Jan 2002 20:19:52 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:44971 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S287831AbSATBTf>; Sat, 19 Jan 2002 20:19:35 -0500
Message-Id: <5.1.0.14.2.20020120011709.027c46e0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 20 Jan 2002 01:22:01 +0000
To: Rob Radez <rob@osinvestor.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH] Andre's IDE Patch (1/7)
Cc: Andre Hedrick <andre@linuxdiskcert.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201191955210.14950-100000@pita.lan>
In-Reply-To: <Pine.LNX.4.10.10201191625110.9354-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I know what Andre is referring to (Andre please correct me if I am 
wrong) and if I am correct than you are still safe to use the currently 
existing big patch (as long as you do NOT tamper with it in any way - I 
mean that, a one line change is sufficient to destroy your data). If you 
split it up, there is a _very_ high chance broken code will be executed 
which will destroy your data on first time a PIO transfer occurs...

Best regards,

Anton

At 00:58 20/01/02, Rob Radez wrote:
>On Sat, 19 Jan 2002, Andre Hedrick wrote:
> > Please don't do that.  There is a fatal flaw in those patches we all
> > observed in 2.5.3pre1.  I have 2.4.16 as a possible candidate and
> > auto-patching for 2.4.17 at the moment.
>
>On Wed, 16 Jan 2002, Andre Hedrick wrote:
> > If the driver falls out of DMA, DEADBOX!!!!
> > There is a conflict of BIO and ACB and it is very fatal.
>
>It was my impression that the problem with 2.5.3-pre1 was a complication
>that existed only because of bio in 2.5.  Oops.  I assume this means then
>that all of us running your ide.2.4.16.12102001.patch should immediately
>revert so Bad Things don't happen?




-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

