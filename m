Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130944AbRA2Olk>; Mon, 29 Jan 2001 09:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131378AbRA2OlY>; Mon, 29 Jan 2001 09:41:24 -0500
Received: from [194.213.32.137] ([194.213.32.137]:3332 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131530AbRA2OlF>;
	Mon, 29 Jan 2001 09:41:05 -0500
Message-ID: <20010128233425.E1300@bug.ucw.cz>
Date: Sun, 28 Jan 2001 23:34:25 +0100
From: Pavel Machek <pavel@suse.cz>
To: "H. Peter Anvin" <hpa@transmeta.com>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Post codes during runtime, possibly OT
In-Reply-To: <200101281012.LAA04278@cave.bitwizard.nl> <3A73F1EB.B6F69A93@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A73F1EB.B6F69A93@transmeta.com>; from H. Peter Anvin on Sun, Jan 28, 2001 at 02:18:19AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Ok. I've thought about it some more, but I don't care enough about
> > this issue to do the painstaking legwork: I don't have one of those
> > POST-code indicators on port 0x80.
> > 
> > I've made the "pause" in outb_p just a few (*) ns slower, because it
> > now loads a variable before outputting the value to port 0x80. As the
> > whole idea about this is "pausing", making it a bit slower shouldn't
> > matter too much.  I've tested it: It compiles, it boots.
> > 
> > I'm not too familar with the syntax of the "asm" statement. So I may
> > illegally be modifying the AX register. I don't care enough about this
> > to figure it out right now.
> > 
> 
> It is; you'd have to specify "eax" as a clobber value, and that is
> undesirable.
> 
> And you're still overwriting the POST value written by the BIOS.

So save value from bios at initial boot ;-).
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
