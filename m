Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313767AbSEVN40>; Wed, 22 May 2002 09:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313789AbSEVN4Z>; Wed, 22 May 2002 09:56:25 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:52913 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313767AbSEVN4Y>;
	Wed, 22 May 2002 09:56:24 -0400
Date: Wed, 22 May 2002 15:56:03 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
Message-ID: <20020522155603.B765@ucw.cz>
In-Reply-To: <3CEB9A1B.9040905@antefacto.com> <E17AWXL-0001md-00@the-village.bc.nu> <20020522154902.A361@ucw.cz> <3CEB9465.6040409@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 02:51:49PM +0200, Martin Dalecki wrote:
> Uz.ytkownik Vojtech Pavlik napisa?:
> > On Wed, May 22, 2002 at 02:52:19PM +0100, Alan Cox wrote:
> > 
> > 
> >>>/sbin/kbdrate: util-linux
> >>
> >>I'd hope kbrate is using the ioctls nowdays, otherwise it will break on USB
> > 
> > 
> > Actually, the ioctls won't work on USB, because they try to output data
> > to the traditional i/o ports anyway.
> 
> 
> So at least we know now:
> 
> 1. Kernel is bogous.
> 2. util-linux is bogous.
> 
> IOCTL is ineed the way to go to implement such functionality...

Yes, the EVIOCSREP ioctl will be the one soon (works for USB keyboards
now).

-- 
Vojtech Pavlik
SuSE Labs
