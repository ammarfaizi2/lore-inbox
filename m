Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279787AbRJ0GaP>; Sat, 27 Oct 2001 02:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279786AbRJ0GaF>; Sat, 27 Oct 2001 02:30:05 -0400
Received: from mail118.mail.bellsouth.net ([205.152.58.58]:17456 "EHLO
	imf18bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S279785AbRJ0G37>; Sat, 27 Oct 2001 02:29:59 -0400
Message-ID: <3BDA5492.110358F2@mandrakesoft.com>
Date: Sat, 27 Oct 2001 02:30:42 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Roskin <proski@gnu.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] More ioctls for VIA sound driver, Flash 5 now fixed
In-Reply-To: <Pine.LNX.4.33.0110262134440.1121-100000@portland.hansa.lan>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Roskin wrote:
> 
> Hello!
> 
> Flash plugin version 5 refuses to work with the VIA 82Cxxx driver.  It
> turns out that Flash uses SNDCTL_DSP_NONBLOCK on /dev/dsp, which is not
> supported by the driver.
> 
> I also looked what other ioctls can be implemented easily on VIA 82Cxxx.
> There is another one - SNDCTL_DSP_GETTRIGGER.  Everything else is not
> trivial, sorry.
> 
> This patch add support for SNDCTL_DSP_NONBLOCK and SNDCTL_DSP_GETTRIGGER.
> It can be found at http://www.red-bean.com/~proski/linux/via-ioctl.diff
> 
> Flash 5 plugin plays just fine after applying the patch (check e.g.
> http://wcrb.com/sparks.html)

Thanks, applied.

I always thought SNDCTL_DSP_NONBLOCK was stupid and never implemented
it, since the same can be accomplished via fcntl(2).  But not only this
but also some soundmodem utilities require this ioctl.  Sigh.  :)

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

