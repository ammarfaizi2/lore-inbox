Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264964AbRGSQNy>; Thu, 19 Jul 2001 12:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264927AbRGSQNp>; Thu, 19 Jul 2001 12:13:45 -0400
Received: from [208.187.172.194] ([208.187.172.194]:25363 "HELO
	odin.oce.srci.oce.int") by vger.kernel.org with SMTP
	id <S264933AbRGSQN3> convert rfc822-to-8bit; Thu, 19 Jul 2001 12:13:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Joshua Schmidlkofer <menion@srci.iwpsd.org>
To: Wakko Warner <wakko@animx.eu.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.6 and netboot
Date: Thu, 19 Jul 2001 10:10:51 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010719082650.A26980@animx.eu.org>
In-Reply-To: <20010719082650.A26980@animx.eu.org>
MIME-Version: 1.0
Message-Id: <01071910105102.01826@widmers.oce.srci.oce.int>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thursday 19 July 2001 06:26 am, Wakko Warner wrote:
> I'm using a kernel that is dd'd to a floppy to net boot linux on random
> machines.  I noticed that 2.4.6 won't get it's IP from the server (it won't
> even attempt it).  2.4.4 works
>
> If any more info is needed, just ask.

Sine 2.4.4 I have been unable to make ipconfig automagically go, and I think 
that this configuration is not supported.   At least, with my limited 
knowledge of how ipconfig works  you must to pass: 'ipconfig=dhcp', or 
ipconfig='bootp' to the kernel at boot time.  I built a LILO disk, but
I think that syslinux would work.  Also, I did eventually successfully get an 
Xterminal running.

After 2.4.4 ipconfig was changed to the ipconfig= style of behaviour.  I 
don't know why, but someone does.  I think it has to do with implementation 
cahnges to allow for modularized NIC's to use ipautoconfig.   This seems 
insane that functionality was cut in order to do this.

Also, I have been unable to make bootp work for nfsboot, but I suspect my 
bootp server - not the kernel.

BACK to the point.  Since 2.4.5 I have had to use lilo, and add a line that 
says 'nfs=[all that stuff] ipconfig=dhcp'

good luck.

js

