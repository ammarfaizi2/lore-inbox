Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312828AbSDKTIH>; Thu, 11 Apr 2002 15:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312842AbSDKTIG>; Thu, 11 Apr 2002 15:08:06 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:57297 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S312828AbSDKTIC>;
	Thu, 11 Apr 2002 15:08:02 -0400
Date: Thu, 11 Apr 2002 21:07:41 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: linux as a minicomputer ?
Message-ID: <20020411210741.A15790@ucw.cz>
In-Reply-To: <20020411154601.GY17962@antefacto.com> <20020411164331.GR612@gallifrey> <20020411184923.A15238@ucw.cz> <20020411170910.GS612@gallifrey> <20020411191339.B15435@ucw.cz> <20020411174941.GC17962@antefacto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 05:49:42PM +0000, John P. Looney wrote:
> On Thu, Apr 11, 2002 at 07:13:39PM +0200, Vojtech Pavlik mentioned:
> > > I'd presumed this was
> > > the whole point of the busid spec in the config file.
> > No, it's for running one Xserver on multiple displays at once only.
> > Sad, ain't it?
> 
>  Very sad. Nice to know it's not really the kernel's fault. 
> 
>  Is it possible to say "Any mice plugged in to this port is
> /dev/input/mouse3" etc. so that if someone plugged out your mouse, plugged
> in another into a different port, and you plugged yours back in, that they
> wouldn't renumberate ?

No, that is not possible. However, on plugging the mouse, /sbin/hotplug
will be called with appropriate arguments to allow to take any action
needed (symlinking, sending a signal, whatever) to make the mouse keep
working. Also a list of existing devices is available under
/proc/bus/input/devices for applications to look at and reconfigure in
case of a hotplug event.

-- 
Vojtech Pavlik
SuSE Labs
