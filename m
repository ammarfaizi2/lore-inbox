Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262361AbSJDUMR>; Fri, 4 Oct 2002 16:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262386AbSJDUMQ>; Fri, 4 Oct 2002 16:12:16 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:19393 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262361AbSJDUKc>;
	Fri, 4 Oct 2002 16:10:32 -0400
Date: Fri, 4 Oct 2002 22:15:54 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: jbradford@dial.pipex.com
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.5.X breaks PS/2 mouse
Message-ID: <20021004221554.A49104@ucw.cz>
References: <200210042020.g94KKQX4007896@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210042020.g94KKQX4007896@darkstar.example.net>; from jbradford@dial.pipex.com on Fri, Oct 04, 2002 at 09:20:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 09:20:26PM +0100, jbradford@dial.pipex.com wrote:
> One of my 486 laptops has a special port on the side, for a dedicated trackball.  I always assumed that it was electrically identical to the standard PS/2 mouse port, which is also present.
> 
> With 2.2.x, (I haven't tried 2.4.x on this machine), both the dedicated trackball and a standard external PS/2 mouse work fine, using /dev/psaux.
> 
> With 2.5.40, however, the behavior is as follows:
> 
> Booting:
> 
> With no pointing devices connected, just the port is detected:
> serio: i8042 AUX port at 0x60, 0x64 irq 12

This is OK.

> With the dedicated trackball connected, it also gets detected:
> input: PS/2 Generic mouse on isa0060/serio1
> serio: i8042 AUX port at 0x60, 0x64 irq 12

Also OK.

> Same with a PS/2 mouse, it also gets detected:
> input: PS/2 Generic mouse on isa0060/serio1
> serio: i8042 AUX port at 0x60, 0x64 irq 12

Also OK.

> Once booted:
> 
> Hot plugging either the dedicated trackball or a PS/2 mouse generates a message on connection:

Good, this is expected.

> Just to clarify, I am not trying to use them both at the same time.

Not sure if that would work, it might - depends on the notebook keyboard
controller hardware.

> X also works with the external PS/2 mouse,

Good.

> but not the dedicated trackball.

What are the exact symptoms? Does gpm work? Does cat /dev/psaux work? Does cat
/dev/input/mice work? What does cat /proc/bus/input/devices say in the
case it doesn't work? ....

> Any suggestions?

Just questions at this time ...

-- 
Vojtech Pavlik
SuSE Labs
