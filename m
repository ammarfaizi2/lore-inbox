Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263507AbTI2PPp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 11:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263541AbTI2PPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 11:15:45 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:23730 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263507AbTI2PPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 11:15:43 -0400
Date: Mon, 29 Sep 2003 17:14:45 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Russell King <rmk@arm.linux.org.uk>,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Bernardo Innocenti <bernie@develer.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Linux 2.6.0-test6
In-Reply-To: <3F784AE9.4040906@nortelnetworks.com>
Message-ID: <Pine.GSO.4.21.0309291713460.7432-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Sep 2003, Chris Friesen wrote:
> Russell King wrote:
> > If a header has something like these:
> > 
> > struct my_headers_struct {
> > 	struct task_struct *tsk;
> > };
> > 
> > void my_function(struct task_struct *tsk);
> > 
> > and gcc warns that "struct task_struct" has not been declared, please
> > don't think about adding another header.  Just declare the structure
> > in the header file which needs it like this:
> > 
> > struct task_struct;
> 
> If I do that, make a change to task_struct, then run make, will the file 
> get rebuilt?

No. But using that definition all you can do (without warnings) is passing
pointers to the struct around, which is OK.

If you want to play with the internals of the structure, you have to include
the right header file anyway.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

