Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318825AbSHWORi>; Fri, 23 Aug 2002 10:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318818AbSHWORi>; Fri, 23 Aug 2002 10:17:38 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:60909 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S318825AbSHWORh>; Fri, 23 Aug 2002 10:17:37 -0400
Date: Fri, 23 Aug 2002 10:21:40 -0400
To: Holger Schurig <h.schurig@mn-logistik.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cell-phone like keyboard driver anywhere?
Message-ID: <20020823142140.GA27454@ravel.coda.cs.cmu.edu>
Mail-Followup-To: Holger Schurig <h.schurig@mn-logistik.de>,
	linux-kernel@vger.kernel.org
References: <200208210932.36132.h.schurig@mn-logistik.de> <E17i91I-0007nB-00@mailer.emlix.com> <200208230954.11132.h.schurig@mn-logistik.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208230954.11132.h.schurig@mn-logistik.de>
User-Agent: Mutt/1.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2002 at 09:54:11AM +0200, Holger Schurig wrote:
> > IMO this should not be done by the kernel, but by the application.
> 
> One can read such stuff all the time ... but really this is not possible in a 
> general way. You don't know in advance if one runs a ncurses, text-only, 
> Qt/Embedded or X-Windows application.
> 
> > - it is easy for the application to check the timing of the
> >   keys pressed and produce the desired characters instead [poll (2)].
> 
> Yes, it's easy to put that in a Qt/Embedded app, but what is when the app 
> terminates?  You could not restart it via the keyboard, because the keyboard 
> is dead. Yeah, it's cumbersome to restart it with a cell-like keyboard, but 
> it's possible.

If the app dies, it should drop you in something like a shell that
should probably simply have the same keyboard decoding code. Or maybe
something smarter. It could use the something like my empeg is using
when searching for song titles.

Press 5 (JKL), all songs starting with either j, k, or l will be
selected, and the display shows 'Kind of Magic'. Press 3 (DEF) and it
limits the selection to any songs that have one of those letters in the
second place. Then press 8 (TUV) and we get 'Let It Be'. So with 3
keypresses I just picked a song out of a selection of almost 1000. I
guess Nokia is doing something similar based on a dictionary.

(or drop back into a menu which doesn't even need key translation)

In any case, how the keys are interpreted is very much application
specific, and can be implemented in a userspace library. I really do not
think it is a good idea to put a complete dictionary or other list of
possible completions in kernel space to implement such alternative input
methods.

> Anyway, I have to write it low-level, in the kernel. I just wondered if 
> something like this already exists.

If you really _have_ to write it low-level in the kernel, it sounds like
a class assignment, in which case you really shouldn't be asking for
existing implementations.

Jan

