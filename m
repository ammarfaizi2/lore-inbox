Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261813AbTCPAp4>; Sat, 15 Mar 2003 19:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261833AbTCPAp4>; Sat, 15 Mar 2003 19:45:56 -0500
Received: from pcp02781107pcs.eatntn01.nj.comcast.net ([68.85.61.149]:50162
	"EHLO linnie.riede.org") by vger.kernel.org with ESMTP
	id <S261813AbTCPApz>; Sat, 15 Mar 2003 19:45:55 -0500
Date: Sat, 15 Mar 2003 19:55:56 -0500
From: Willem Riede <wrlk@riede.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>,
       dan carpenter <d_carpenter@sbcglobal.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Any hope for ide-scsi (error handling)?
Message-ID: <20030316005556.GM7082@linnie.riede.org>
Reply-To: wrlk@riede.org
References: <Pine.LNX.4.50.0303151343140.9158-100000@montezuma.mastecende.com> <200303151926.h2FJQLnB103490@pimout1-ext.prodigy.net> <Pine.LNX.4.50.0303151453010.9158-100000@montezuma.mastecende.com> <200303152012.h2FKCulK283698@pimout2-ext.prodigy.net> <Pine.LNX.4.50.0303151519240.9158-100000@montezuma.mastecende.com> <20030315210120.GI7082@linnie.riede.org> <1047777805.1327.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1047777805.1327.23.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sat, Mar 15, 2003 at 20:23:26 -0500
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003.03.15 20:23 Alan Cox wrote:
> On Sat, 2003-03-15 at 21:01, Willem Riede wrote:
> > It may not be elegant to schedule(1) with the lock taken, but it
> > does work.
> 
> You can't sleep holding a lock. You also can't null the hwgroup that
> way and you have to deal with some other locking concerns. Have a look
> how HDIO_*_RESET is handled in the very latest 2.4/2.5-ac code and
> you should be able to follow from that. Note your code paths will be
> much like the ioctl as the existing reset code paths are for paths
> where we abort from a known safe state (drive initiated or locked).
> 
> With the stuff there now you should be able to abort the command
> fairly cleanly and then reset the interface.
> 
I hear you, and I will take a hard look at that code. But please
realize, that if we get to this code segment, the drive has _not_ 
responded to the regular command and is in an _unknown_ state.

Thanks, Willem Riede.
