Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSGYMx6>; Thu, 25 Jul 2002 08:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312938AbSGYMx6>; Thu, 25 Jul 2002 08:53:58 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:35083 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S312590AbSGYMx5>; Thu, 25 Jul 2002 08:53:57 -0400
Date: Thu, 25 Jul 2002 08:51:28 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@redhat.com>
cc: Andrew Rodland <arodland@noln.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -ac] Panicking in morse code
In-Reply-To: <200207200035.g6K0ZFN11415@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.3.96.1020725084540.11202C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2002, Alan Cox wrote:

> > +static const char * morse[] = {
> > +	".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", /* A-H */
> > +	"..", ".---.", "-.-", ".-..", "--", "-.", "---", ".--.", /* I-P */
> > +	"--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", /* Q-X */
> > +	"-.--", "--..",	 	 	 	 	 	 /* Y-Z */
> > +	"-----", ".----", "..---", "...--", "....-",	 	 /* 0-4 */
> > +	".....", "-....", "--...", "---..", "----."	 	 /* 5-9 */
> 
> How about using bitmasks here. Say top five bits being the length, lower
> 5 bits being 1 for dash 0 for dit ?

??? If the length is 1..5 I suspect you could use the top two bits and fit
the whole thing in a byte. But since bytes work well, use the top three
bits for length without the one bit offset. Still a big win over strings,
although a LOT harder to get right by eye.

I want to see this go to the sound card, so that when the admins are in
the ready room drinking coffee and listening to mp3s over the speakers
they will "get the message." Actually one guys says he can read morse in
his sleep, when he's "studying a manual" head down we might see about
that;-)

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

