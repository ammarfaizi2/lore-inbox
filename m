Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132229AbRCYWe7>; Sun, 25 Mar 2001 17:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132231AbRCYWeu>; Sun, 25 Mar 2001 17:34:50 -0500
Received: from linas.org ([207.170.121.1]:36600 "HELO backlot.linas.org")
	by vger.kernel.org with SMTP id <S132229AbRCYWek>;
	Sun, 25 Mar 2001 17:34:40 -0500
Subject: mouse problems in 2.4.2
To: linux-kernel@vger.kernel.org
Date: Sun, 25 Mar 2001 16:33:58 -0600 (CST)
From: linas@linas.org
X-Hahahaha: hehehe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010325223358.71E5F1B7A4@backlot.linas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

I am experiencing debilitating intermittent mouse problems & was about 
to dive into the kernel to see if I could debug it.  But first, I thought
a quick note to the mailing list may help.

Symptoms:
After a long time of flawless operation (ranging from nearly a week to 
as little as five minutes), the X11 pointer flies up to top-right corner, 
and mostly wants to stay there.  Moving the mouse causes a cascade of 
spurious button-press events get generated.

This did not occur with 2.4.0test2 or 2.2.16 (to the best of my
recollection) and first showed up in 2.4.0test7 or 2.4.1 (not sure).
With 2.4.2, the symptoms seem slightly different (almost all pointer
movement events seem to be lost; although spurious button-press events
still happen).

Mouse is a logitech trackman marble, with USB connector to
logitech-supplied USB to ps/2 DIN plug.  Configured as a PS/2 mouse.
Motherboard is a Athalon/VIA Apollo KA7.

Unplugging mouse for 10 seconds sometimes fixes the problem on the sixth
try, sometimes. 

Switching to virtual terminal running gpm, and back to X11 used to fix
the problem, sometimes, after some magic incantations, unplugging,
starting gpm, moving mouse, etc.  This no longer does the trick w/
2.4.2.

Rebooting X11 frequently, but not always, fixed the problem.

The *only* sure-fire fix is to reboot the system. 

Sometimes, the mouse seemed usable with gpm even as it wasn't with X11;
sometimes it had the same bad behaviour (scooting to the corner,
spurious button-press) even under gpm.

Changing mouse protocols to imps2 from ps2 in gpm/X11 seems to make no
difference.

Disabling power management in kernel and bios to various degrees (including 
disabling *all* power management) doesn't seem to fix anything.  (It
was suggested to me that this was an APM bug; indeed, an early
manifestation of the bug seemed to be that it triggered if/when I moved
the mouse just as the video-powersave triggered. )

Sometimes, the problem seems to be associated with moving the mouse
during CPU-intensive or disk-i/o intensive operations (e.g. a large 
file copy, compile; or system activity during mp3 playing) Lost
interrupt?

On rare ocasions, its associated with system lockup.  (specifically,
some keyboard buffer seems to fill up, and everything seems hung,  
not even ctrl-alt-del works).  (I haven't checked to see if I can 
still telnet in). 

I've been living with this problem for 6+ months, and it is getting to
be infuriating.  As you can see above, all sorts of different attempts
above make subtle variations in the symptoms, but no fixes.  

I conclude that this is probably a hardware (motherboard chipset)
bug, that its rare (google/deja  searches are unfruitful) and that 
the only place to hunt is in the kernel. 

---------------
So: any advice, comments, suggestions before I embark on a long and
possibly fruitless hunt?  Any recommendations for best tools/proceedures
to catch it 'in the act'?  

--linas

p.s. direct replies to linas@linas.org appreciated.



