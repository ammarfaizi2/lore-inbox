Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264762AbTFEQ6Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 12:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264763AbTFEQ6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 12:58:23 -0400
Received: from uldns1.unil.ch ([130.223.8.20]:919 "EHLO uldns1.unil.ch")
	by vger.kernel.org with ESMTP id S264762AbTFEQ6W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 12:58:22 -0400
Date: Thu, 5 Jun 2003 19:11:51 +0200
From: Gregoire Favre <greg@magma.unil.ch>
To: Michael Hunold <hunold@convergence.de>
Cc: linux-kernel@vger.kernel.org, linux-dvb@linuxtv.org
Subject: Re: [linux-dvb] Re: Can't boot since 2.4.21-rc2-ac3 with dvb-kernel
Message-ID: <20030605171151.GA18492@magma.unil.ch>
References: <20030602171613.GA1609@magma.unil.ch> <20030605163932.GA17573@magma.unil.ch> <3EDF742C.2040500@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3EDF742C.2040500@convergence.de>
User-Agent: Mutt/1.4.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 06:47:40PM +0200, Michael Hunold wrote:

Hello Michael and otherss ;-)

> Are you sure you have used the v4l2 "videodev.o" (backported from 2.5) 
> that comes from the "build-2.4" directory from the "dvb-kernel" cvs tree?

Argh!!!

> Please do a
> > find /lib/modules/ -iname "*videodev*"

/lib/modules/2.4.20-xfs-2003-04-27/kernel/drivers/media/video/videodev.o
/lib/modules/2.4.21-rc1-ac3/misc/videodev.o
/lib/modules/2.4.21-rc2-ac2/misc/videodev.o
/lib/modules/2.4.21-rc2-ac3/misc/videodev.o
/lib/modules/2.4.21-rc2-ac3/kernel/drivers/media/video/videodev.o
/lib/modules/2.4.21-rc6-ac1/misc/videodev.o
/lib/modules/2.4.21-rc6-ac1/kernel/drivers/media/video/videodev.o
/lib/modules/2.4.21-rc7-ac1/misc/videodev.o
/lib/modules/2.4.21-rc7-ac1/kernel/drivers/media/video/videodev.o
/lib/modules/2.4.20-xfs/misc/videodev.o

I completely forgot this!!!

> If you have a "videodev.o" in .../kernel/drivs/media/video, then this 
> will be used. But this is the plain old 2.4 video4linux-*1* videodev 
> module, which does not work in conjunction with the "dvb-kernel" CVS 
> driver, which needs the 2.5 video4linux-*2* videodev.

Well, I have rebooted now under 2.4.21-rc7-ac1 and it works just
great!!!

> Please don't CC the linux kernel mailing list the next time, since this 
> is a dvd only issue. Thanks!

I completely agree with this, unfirtunately, as I completely forgot to
remove the kernel/drivers/media/video/videodev.o to kernels newer than
2.4.21-rc2-ac2 and as the compilation of new dvb-kernel worked perfectly
for 2.4.21-rc2-ac2 I thought it was due to a change in the kernel...

Sorry for the posts!!! But thank you very much,

	Grégoire
__________________________________________________________________
http://www-ima.unil.ch/greg ICQ:16624071 mailto:greg@magma.unil.ch
