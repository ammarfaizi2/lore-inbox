Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280800AbRKTAOj>; Mon, 19 Nov 2001 19:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280801AbRKTAOT>; Mon, 19 Nov 2001 19:14:19 -0500
Received: from adsl-63-194-247-216.dsl.lsan03.pacbell.net ([63.194.247.216]:31936
	"EHLO www.vinyltribe.com") by vger.kernel.org with ESMTP
	id <S280790AbRKTAN5>; Mon, 19 Nov 2001 19:13:57 -0500
Date: Mon, 19 Nov 2001 16:16:18 -0800 (PST)
From: Emiliano Garcia <emi@vinyltribe.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.4.14 breaks NVIDIA-1.0-1541 console switching
In-Reply-To: <3BF99977.4090003@free.fr>
Message-ID: <Pine.LNX.4.33.0111191603190.7908-100000@www.vinyltribe.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2001, Lionel Bouton wrote:

> 
> 
> PVotruba@Chemoprojekt.cz wrote:
> 
> >Hi,
> >Please try to be more specific. Do you use VGA textmode console or NVidia
> >console framebuffer? I had also some freezes due to console framebuffer,
> >after returning closing X - the command line never appeared again. Try to
> >use only textmode console, NVidia framebuffer is currently in EXPERI-MENTAL
> >state :)
> >
> Very experimental on my box, it broked hard the last time I tried (SMP 
> 2.4.13-ac7) on my config :
> lockup on first X -> fb console switch , SysRq worked for 
> sync/umount/reboot, didn't tried blind "killall X" in initlevel 5 though 
> (so X restart not tested).
> If the maintainer wants some testing on a SMP with a Geforce2 MX, with 
> every single partition reiserfs or ext3 mounted I can afford reboots now 
> (130 GB on 4 IDE drives weren't especially fast to fsck)...
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


This is interesting, I've been having the same problem. However, in my 
struggle to fix this blatant hang I've disabled my nvidia driver, 
disabled glx, dri, and framebuffer, only to find that with the stock XFree 
4.0.3 and 4.1.0 nv driver I can't logout halt, control-alt-backspace or 
switch to a console without hanging the machine. No signs of what is 
amiss, it hangs at a hardware level. Since I've removed the NVidia driver 
I can safely say it's not the cause of the hang (at least in my case). I'm 
going to try going back to a 2.4.3 or so kernel to see if that helps, that 
is if my volume survives another few fscks without completely messing 
everything up.

I'm running an Athlon XP 1800+ with a geforce 2 pro ddr, AMD 761 
northbridge chipset with VIA southbridge. Linux-2.4.15-pre6. Any knowledge 
about this is greatly appreciated. 

A week ago I was running a P3 1GHz with an 815 chipset, the same setup, 
and it was ticking along perfectly. I have a feeling it's something to do 
with this chipset, but like I said I'm not even loading agpgart now and it 
still freezes.

Symptom: halt, logout, or console switch hangs linux with a hard lock.

