Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291450AbSBHHVF>; Fri, 8 Feb 2002 02:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291451AbSBHHUz>; Fri, 8 Feb 2002 02:20:55 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:9488 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S291450AbSBHHUp>;
	Fri, 8 Feb 2002 02:20:45 -0500
Date: Fri, 8 Feb 2002 08:20:25 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Nathan <wfilardo@fuse.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Mouse under 2.5.3-dj3
Message-ID: <20020208082025.B2995@suse.cz>
In-Reply-To: <3C633DDB.9050607@fuse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C633DDB.9050607@fuse.net>; from wfilardo@fuse.net on Thu, Feb 07, 2002 at 09:54:19PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 09:54:19PM -0500, Nathan wrote:
> To follow up on my previous postings of a long while ago.
> 
> I have a very boring trackpad mouse on a Sony VAIO R505JE laptop.  At 
> least, 2.4.18-pre7 thinks it's normal PS/2 and uninteresting.  2.5.3-dj* 
> on the other hand, seems to be horribly confused.  I rebuilt it with 
> everything mouse related as modules just so I didn't have to reboot when 
> it misdetected my mouse.
> 
> First, I modprobe mousedev, then psmouse.
> Mousedev always is cool and loads without a problem, printing out its 
> "PS/2 mouse device common for all mice" message.
> 
> ~90% of the time, psmouse does not detect a mouse.  Doesn't work, obviously.
> ~5% of the time, psmouse reports I have a "PS/2 Generic Mouse on 
> isa0060/serio1".
>     At such times, the mouse works, but a complete cross on the trackpad 
> is ~100 pixels at best.
> ~1% of the time, psmouse blurts "Failed to enable mouse on 
> isa0060/serio1"  Here the mouse does not work.
> ~4% of the time, psmouse prints "PS/2 Logitech Mouse on isa0060/serio1" 
>  This is the correct mode of behavior.
> 
> As it is I run "modprobe mousedev; while < /dev/zero; do modprobe 
> psmouse; echo -n "a"; sleep 1; done" and wait for the Logitech message 
> to give the loop a Ctrl-C.  There has to be a better way, and more 
> information I can provide.
> 
> FYI, keyboard glitches *seem* to have disappeared.

Can you enable I8042_DEBUG_IO in drivers/input/serio/i8042.h and send me
the 'dmesg' logs for the four cases? It might be the touchpad is
responding just on the limit of what the psmouse driver thinks is the
slowest possible speed.

-- 
Vojtech Pavlik
SuSE Labs
