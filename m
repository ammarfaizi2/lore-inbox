Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288767AbSAVQkg>; Tue, 22 Jan 2002 11:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288814AbSAVQk0>; Tue, 22 Jan 2002 11:40:26 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:7947 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S288767AbSAVQkV>;
	Tue, 22 Jan 2002 11:40:21 -0500
Date: Tue, 22 Jan 2002 17:40:17 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.2-dj4
Message-ID: <20020122174017.A14033@suse.cz>
In-Reply-To: <20020122141609.A3379@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020122141609.A3379@suse.de>; from davej@suse.de on Tue, Jan 22, 2002 at 02:16:09PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2002 at 02:16:09PM +0000, Dave Jones wrote:

> This syncs up to pre2 (pre3 next time), and includes Vojtech's (and others)
> input layer reworking to get it some more testing before it goes Linuswards.
> Anyone with any input device (yes, even just a keyboard)
> now has to enable this, and the relevant keyboard driver.

To extend this a little further, for a normal PS/2 keyboard and mouse
setup you need to enable the following options (or load the appropriate
modules):

Input device support  --->
	Input core support			(input.o)	
	  Keyboard interface			(keybdev.o)
	  Mouse interface			(mousedev.o)
	Serial i/o support			(serio.o)
	  i8042 PC Keyboard controller		(i8042.o)
	Keyboards
	  AT keyboard support			(atkbd.o)
	Mice
	  PS/2 mouse				(psmouse.o)

Note that you also have to change XF86Config and GPM to use /dev/input/mice
instead of /dev/psaux.

-- 
Vojtech Pavlik
SuSE Labs
