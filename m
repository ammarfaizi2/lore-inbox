Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318587AbSGSQ6y>; Fri, 19 Jul 2002 12:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318586AbSGSQ6y>; Fri, 19 Jul 2002 12:58:54 -0400
Received: from admin.nni.com ([216.107.0.51]:49423 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S318587AbSGSQ6x>;
	Fri, 19 Jul 2002 12:58:53 -0400
Date: Fri, 19 Jul 2002 13:00:40 -0400
From: Andrew Rodland <arodland@noln.com>
To: dl8bcu@dl8bcu.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -ac] Panicking in morse code
Message-Id: <20020719130040.191091cd.arodland@noln.com>
In-Reply-To: <20020719163654.A6010@Marvin.DL8BCU.ampr.org>
References: <20020719011300.548d72d5.arodland@noln.com>
	<20020719163654.A6010@Marvin.DL8BCU.ampr.org>
X-Mailer: Sylpheed version 0.7.8claws55 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2002 16:36:55 +0000
Thorsten Kranzkowski <dl8bcu@dl8bcu.de> wrote:

> On Fri, Jul 19, 2002 at 01:13:00AM -0400, Andrew Rodland wrote:
> > I was researching panic_blink() for someone who needed a little
> > help, when I noticed the comment above the function definition, not
> > being the kind to step down from a challenge (unless it's just
> > really hard), I decided to write morse code output code.
> 
> nice idea :)
> 
> > diff -u -r -d linux.old/drivers/char/pc_keyb.c
> > linux/drivers/char/pc_keyb.c--- linux.old/drivers/char/pc_keyb.c	Fri Jul 19 00:59:04 2002
> > +++ linux/drivers/char/pc_keyb.c	Fri Jul 19 01:00:34 2002
> > @@ -1244,37 +1244,126 @@
> >  #endif /* CONFIG_PSMOUSE */
> 
> [...]
> 
> > +static const char * morse[] = {
> > +	".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", /* A-H
> > */+	"..", ".---.", "-.-", ".-..", "--", "-.", "---", ".--.", /* I-P
> > */
> 
> This should read:
> 
> 	"..", ".---", "-.-", ".-..", "--", "-.", "---", ".--.", /* I-P
> 	*/
> 
> i.e. there's a dot too much :)
> 

Thank you. Fixed locally.
Since you seem to be something of a morse-wiz (the only letters I know
by heart are 'S', 'O', and 'S'), could you either make corrections on
my timings (ditlen, dahlen, inter-letter space, inter-word space), or
tell me that they're good?

--Andrew

P.S. Yes, in case anyone is wondering, I did create a module that does
nothing but generate a user-supplied panic. :)


