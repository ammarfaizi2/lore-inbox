Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263010AbSJGMef>; Mon, 7 Oct 2002 08:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263012AbSJGMee>; Mon, 7 Oct 2002 08:34:34 -0400
Received: from 62-190-218-67.pdu.pipex.net ([62.190.218.67]:1544 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S263010AbSJGMee>; Mon, 7 Oct 2002 08:34:34 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210071246.g97CkLs0002126@darkstar.example.net>
Subject: Re: 2.5.X breaks PS/2 mouse
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Mon, 7 Oct 2002 13:46:20 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021007140916.A660@ucw.cz> from "Vojtech Pavlik" at Oct 07, 2002 02:09:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Pressing the left button, then the right button, (this is complete, and follows the above immediately):
> > 
> > i8042.c: 01 <- i8042 (interrupt, aux, 12) [230409]
> > i8042.c: 00 <- i8042 (interrupt, aux, 12) [230410]
> > i8042.c: 00 <- i8042 (interrupt, aux, 12) [230411]
> > i8042.c: 00 <- i8042 (interrupt, aux, 12) [230548]
> > i8042.c: 00 <- i8042 (interrupt, aux, 12) [230552]
> > i8042.c: 00 <- i8042 (interrupt, aux, 12) [230554]
> > i8042.c: 02 <- i8042 (interrupt, aux, 12) [231505]
> > i8042.c: 00 <- i8042 (interrupt, aux, 12) [231506]
> > i8042.c: 00 <- i8042 (interrupt, aux, 12) [231507]
> > i8042.c: 00 <- i8042 (interrupt, aux, 12) [231694]
> > i8042.c: 00 <- i8042 (interrupt, aux, 12) [231695]
> > i8042.c: 00 <- i8042 (interrupt, aux, 12) [231696]
> > 
> > So, it definitely seems to be sending data to the port...  Strange...
> 
> It must work. I'm really wondering why it doesn't. What happens when you
> load the 'evbug' module?

I can't very easily - the kernel on the machine doesn't have kernel module support enabled, and with 4MB RAM, it's really painfully slow to work with if I use a kernel with modules enabled.  If there is no other way to debug it, I can try, but it's a last resort :-)

Something that occurred to me, and I could be totally wrong here, but is it possible that the trackball is being detected as a "generic mouse" when it isn't one?

I tried connecting the generic mouse, disconnecting it, and then connecting the trackball, and saw in dmesg that some kind of handshake was going on.  This was completely different for mouse and trackball.  Would it be any use to post this output?

If the evbug module is the only way to go, I'll try it, but it'll probably take me the rest of the day, (seriously) :-).

John.
