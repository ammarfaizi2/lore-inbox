Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266993AbSL3QLE>; Mon, 30 Dec 2002 11:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266994AbSL3QLE>; Mon, 30 Dec 2002 11:11:04 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:27777
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266993AbSL3QLD>; Mon, 30 Dec 2002 11:11:03 -0500
Subject: Re: 2-4-18 crash trying to blank a CD
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luca z <luca22@mail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021230155739.76748.qmail@mail.com>
References: <20021230155739.76748.qmail@mail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Dec 2002 17:01:03 +0000
Message-Id: <1041267663.13615.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-30 at 15:57, Luca z wrote:
> I do cdrecord -blank=<foo> dev=x,y,z
> and i got this in the log, it repeats every second:
> 
> Dec 30 16:19:46 koala kernel: scsi : aborting command due to timeout : pid 5233
> 8, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 13 80 dd 00 00 01 00 
> Dec 30 16:19:46 koala kernel: SCSI host 0 abort (pid 52338) timed out - resetti
> ng

How long after you start the command ? Basically the kernel has
discovered that the command in question took longer than the timeout
cdrecord told it to allow. It is then trying to get the system back.


> and after some time it hard freezes, nothing responds, i can't switch numlock
> off and i can't change to console (i am in XWindow).

Can you see what occurs if you are not in X windows as that might
display an oops or other information of use.


