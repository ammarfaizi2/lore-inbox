Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129624AbRDAAJC>; Sat, 31 Mar 2001 19:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130454AbRDAAIw>; Sat, 31 Mar 2001 19:08:52 -0500
Received: from snowstorm.mail.pipex.net ([158.43.192.97]:52472 "HELO
	snowstorm.mail.pipex.net") by vger.kernel.org with SMTP
	id <S129624AbRDAAIc>; Sat, 31 Mar 2001 19:08:32 -0500
To: linux-kernel@vger.kernel.org
From: Trevor-Hemsley@dial.pipex.com (Trevor Hemsley)
Date: Sat, 31 Mar 2001 11:01:59
Subject: Re: Matrox G400 Dualhead
X-Mailer: ProNews/2 V1.51.ib103
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20010401000842Z129624-406+6183@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Mar 2001 07:17:19, "Rafael E. Herrera" 
<raffo@neuronet.pitt.edu> wrote:

> J Brook wrote:
> > 
> > >With 2.4.2 it was working just fine.
> > 
> > I have also noticed problems with the 2.4.3 release. I have a G450
> > 32Mb, that I use in single-head mode. The console framebuffer runs
> > fine at boot time, but when I load X (4.0.3 compiled with Matrox HAL
> > library) and then return to the console, I get a blank screen (signal
> > lost).
> 
> In my case, when lilo boots my G450 on any video mode other than
> 'normal', going into X and then back into console, leads to a blank
> screen. I've observed this behavior in 2.2 and 2.4. Otherwise, I've no
> problem using the card in single or dual head.

I get this as well on my G200. From observation it appears that the 
refresh rate is being doubled when you exit X and that's why the 
console appears blank. On my system I normally use

modprobe matroxfb vesa=263 fv=85

to give a large text console. On return from X, if I blindly type

fbset "640x480-60"

then I get a visible screen back but my monitor tells me that it's 
running at 640x480@119Hz. Same thing for 800x600-60 only this one says
120Hz.

Base system is SuSE 7.1 using XFree86 4.0.2. If I switch to 3.3.6 then
it works OK. If I don't load matroxfb then it also works OK.

-- 
Trevor Hemsley, Brighton, UK.
Trevor-Hemsley@dial.pipex.com
