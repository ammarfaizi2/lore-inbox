Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131564AbRC0UrK>; Tue, 27 Mar 2001 15:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131578AbRC0Uqu>; Tue, 27 Mar 2001 15:46:50 -0500
Received: from linas.org ([207.170.121.1]:14588 "HELO backlot.linas.org")
	by vger.kernel.org with SMTP id <S131564AbRC0Uqj>;
	Tue, 27 Mar 2001 15:46:39 -0500
Subject: Re: mouse problems in 2.4.2 -> lost byte
To: Gunther.Mayer@t-online.de (Gunther Mayer)
Date: Tue, 27 Mar 2001 14:45:51 -0600 (CST)
Cc: linas@linas.org, linux-kernel@vger.kernel.org
In-Reply-To: <3AC0F4D5.9E45E60C@t-online.de> from "Gunther Mayer" at Mar 27, 2001 10:15:17 PM
From: linas@linas.org
X-Hahahaha: hehehe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010327204551.623181B7A5@backlot.linas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's been rumoured that Gunther Mayer said:
> 
> > I am experiencing debilitating intermittent mouse problems & was about
> ...
> > Symptoms:
> > After a long time of flawless operation (ranging from nearly a week to
> > as little as five minutes), the X11 pointer flies up to top-right corner,
>                                                           ^^^^^^^^^^^^^^^^
> > and mostly wants to stay there.  Moving the mouse causes a cascade of
> > spurious button-press events get generated.
> 
> This is easily explained: some byte of the mouse protocol was lost.

Bing!

That's it! This would also explain why gpm seems to work i.e. correctly
process the events, even when X11 can't.  I will take this up on the
Xf86 lists ...

> (Some mouse protocols are even designed to allow
>  easy resync/recovery by fixed bit patterns!)

This mouse seems to set every fourth byte to zero, which should allow
syncing ...  
I'm still investigating to see if the kernel buffer is overflowing ...


--linas
