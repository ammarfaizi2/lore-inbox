Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263008AbSJGMhQ>; Mon, 7 Oct 2002 08:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263013AbSJGMhQ>; Mon, 7 Oct 2002 08:37:16 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:42112 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263008AbSJGMhO>;
	Mon, 7 Oct 2002 08:37:14 -0400
Date: Mon, 7 Oct 2002 14:42:50 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: jbradford@dial.pipex.com
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.X breaks PS/2 mouse
Message-ID: <20021007144250.A626@ucw.cz>
References: <20021007140916.A660@ucw.cz> <200210071246.g97CkLs0002126@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210071246.g97CkLs0002126@darkstar.example.net>; from jbradford@dial.pipex.com on Mon, Oct 07, 2002 at 01:46:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 01:46:20PM +0100, jbradford@dial.pipex.com wrote:
> > > Pressing the left button, then the right button, (this is complete, and follows the above immediately):
> > > 
> > > i8042.c: 01 <- i8042 (interrupt, aux, 12) [230409]
> > > i8042.c: 00 <- i8042 (interrupt, aux, 12) [230410]
> > > i8042.c: 00 <- i8042 (interrupt, aux, 12) [230411]
> > > i8042.c: 00 <- i8042 (interrupt, aux, 12) [230548]
> > > i8042.c: 00 <- i8042 (interrupt, aux, 12) [230552]
> > > i8042.c: 00 <- i8042 (interrupt, aux, 12) [230554]
> > > i8042.c: 02 <- i8042 (interrupt, aux, 12) [231505]
> > > i8042.c: 00 <- i8042 (interrupt, aux, 12) [231506]
> > > i8042.c: 00 <- i8042 (interrupt, aux, 12) [231507]
> > > i8042.c: 00 <- i8042 (interrupt, aux, 12) [231694]
> > > i8042.c: 00 <- i8042 (interrupt, aux, 12) [231695]
> > > i8042.c: 00 <- i8042 (interrupt, aux, 12) [231696]
> > > 
> > > So, it definitely seems to be sending data to the port...  Strange...
> > 
> > It must work. I'm really wondering why it doesn't. What happens when you
> > load the 'evbug' module?
> 
> I can't very easily - the kernel on the machine doesn't have kernel module support enabled, and with 4MB RAM, it's really painfully slow to work with if I use a kernel with modules enabled.  If there is no other way to debug it, I can try, but it's a last resort :-)

Do you have 'evdev' (Event interface) compiled in? It'd be a replacement
for evbug ...

> Something that occurred to me, and I could be totally wrong here, but
> is it possible that the trackball is being detected as a "generic
> mouse" when it isn't one?

Most likely (95%) it behaves a generic ps/2 mouse. After all, it seems
to send generic ps/2 data. Why the data isn't getting through, is the
question.

> I tried connecting the generic mouse, disconnecting it, and then
> connecting the trackball, and saw in dmesg that some kind of handshake
> was going on.  This was completely different for mouse and trackball.
> Would it be any use to post this output?

If it was different, then definitely!

> If the evbug module is the only way to go, I'll try it, but it'll
> probably take me the rest of the day, (seriously) :-).

Let's try other ways before that.

-- 
Vojtech Pavlik
SuSE Labs
