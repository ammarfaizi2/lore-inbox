Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263134AbUE3LkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbUE3LkV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 07:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263121AbUE3LkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 07:40:21 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:5352 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S263134AbUE3LkE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 07:40:04 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
References: <xb7r7t2b3mb.fsf@savona.informatik.uni-freiburg.de>
	<20040530111847.GA1377@ucw.cz>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 30 May 2004 13:40:03 +0200
In-Reply-To: <20040530111847.GA1377@ucw.cz>
Message-ID: <xb71xl2b0to.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Vojtech" == Vojtech Pavlik <vojtech@suse.cz> writes:

    Vojtech> Q2: What application should be looking at the raw data
    Vojtech> outside the kernel and why?
    >>  What application should be looking at the raw data from an
    >> RS232 port outside the kernel and why?

    Vojtech> Terminal. Terminals use the data directly.

Now, what prevents people from  connecting terminals to a computer via
the PS/2 mouse port?

There are  mice which can be attached  to both the RS232  port AND the
PS/2 mouse port, needing only  an adaptor.  It should also be possible
to use  a similar technique  to connect a  terminal to the  PS/2 mouse
port.  This would be useful when you run out of RS232 ports.

Your  approach   in  the  input  system  completely   rules  out  this
possibility.


    Vojtech> Anyway, the RS232 port is a multi purpose port, where you
    Vojtech> can attach many different devices to it. For the keyboard
    Vojtech> port, there is only one option, the keyboard. 

What a big assumption.  Yes, I admit that I don't know of any hardware
implementations  that use  the PS/2  (or AT)  keyboard port  for other
purposes.  Maybe there are POS systems like that?


    Vojtech> Of course, unless you create a device that can use it,
    Vojtech> but in that case you can easily write a kernel driver for
    Vojtech> it.

How about  the PS/2 mouse  port?  It's not  just for mice.   There ARE
implementations using it for other things: touchpad, touchscreen, etc.
Your input  driver places that  stupid assumption that there  can't be
other devices  outside your support list  that may use  the PS/2 mouse
port, and  you make the  stupid assumption on  HOW the port  should be
used.  That's within your  imaginations.  You're limiting other people
to  your own  imaginations.   Worse still,  there  are ALREADY  things
beyond your imaginations.



    >> In a nutshell, I hate to be restricted by YOUR own imaginations
    >> of how people should hack the system.

    Vojtech> You're not. You're free to hack the kernel drivers. 

Not everyone using  Linux is patient enough to  explore the Wonderland
of kernel hacking.  Many immigrants from 2.4 are highly disappointed
by the new but incompatible mouse/keyboard behaviours.  Some of them
returned to their 2.4 homeland because of this.

Not every new immigrant are that devoted to make the new country good.
Many simply hop  back to the original country, or  hop to another that
_may_ suit them better.



    >> Raw keyboard data, for instance, can be captured for analyzing
    >> how people use the keyboard and coming up with a more efficient
    >> keyboard layout (c.f. Dvorak).  That's already beyond your
    >> imaginations.

    Vojtech> The raw data not what you want to use there. You want the
    Vojtech> keystroke data,

No.   I want  the  raw bytes.   (That's  also useful  for debugging  a
hardware,  in  case  people  are  making  or  experimenting  with  new
hardware.)


    Vojtech>  and for that you can use the /dev/input/event interface,

But that's polluted  with some (0,0,0) events.  In  some situations, I
NEED the raw, uninterpreted bytes,  much like people liking to watch a
film or read  a book in the *original* language  version, not a dubbed
or translated version.

    Vojtech> where you get them in a sane format (as opposed to the
    Vojtech> PS/2 rawmode, which can send up ot 8 bytes for a single
    Vojtech> keystroke).

Sane != helpful or more useful.

I could study the  I-Ching in English, but I would prefer  to do it in
Chinese.  Now, your  approach is forcing me to do  it in English.  And
you believe that's a good idea.



    Vojtech> Then your statistic analyser will work just fine even on
    Vojtech> a Sun, Mac, or with an USB keyboard.

But it will not be able  to handle the specifics.  (That's the problem
with  generic tools  in  general.  But  you  shouldn't be  restricting
people to only those tools.  Some people have specific needs, and they
should not be ignored.)



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

