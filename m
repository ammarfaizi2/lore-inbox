Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278085AbRKHULx>; Thu, 8 Nov 2001 15:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278081AbRKHULg>; Thu, 8 Nov 2001 15:11:36 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:56337 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S278038AbRKHUL2>; Thu, 8 Nov 2001 15:11:28 -0500
Date: Thu, 8 Nov 2001 21:11:26 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Steve Underwood <steveu@coppice.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kermel ML <linux-kernel@vger.kernel.org>
Subject: Re: VIA 686 timer bugfix incomplete
Message-ID: <20011108211126.B6266@suse.cz>
In-Reply-To: <E161RcS-0003x8-00@the-village.bc.nu> <3BE98BA9.7090102@coppice.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BE98BA9.7090102@coppice.org>; from steveu@coppice.org on Thu, Nov 08, 2001 at 03:29:45AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 03:29:45AM +0800, Steve Underwood wrote:
> Alan Cox wrote:
> 
> >>but it seems that the patch was incomplete: The bug is still triggered on my
> >>computer using 2.4.14, but the bugfix seems to work whith -ac kernels.
> >>
> > 
> > The first piece is in.
> > 
> > 
> >>you can see what's missing to actually work around the via timer bug. I hope
> >>this will go into 2.4.15.
> >>
> > 
> > I don't plan to submit it until the locking fixes for the timer access are
> > done and we know the real cause
> 
> 
> If the messages:
> 
> probable hardware bug: clock timer configuration lost - probably a 
> VIA686a motherboard.
> probable hardware bug: restoring chip configuration.
> 
> are really related to a VIA686A bug, why do they erratically appear on 
> Compaq ML370's, which use ServerWorks chip sets? Is there a common bug 
> between these chip sets? Seems unlikely.

Just to make sure: Is on the system the Ftape of any joystick driver in
use? If not, then:

The ServerWorks chip set has a bug that is shared with old Intel Neptune
chipset most likely. This is a problem per se, but also triggers the VIA
bug workaround. The VIA bug test can be enhanced to detect this false
alarm, but the Neptune-like bug still stays and is dangerous as well.

At least the VIA workaround told us something fishy is happening on
non-VIA hardware as well.

For example on my VIA686a/cg (late revision), the workaround is never
triggered.

-- 
Vojtech Pavlik
SuSE Labs
