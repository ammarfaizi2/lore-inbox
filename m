Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261389AbSJHRNF>; Tue, 8 Oct 2002 13:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261412AbSJHRNF>; Tue, 8 Oct 2002 13:13:05 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:65289 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id <S261389AbSJHRND>;
	Tue, 8 Oct 2002 13:13:03 -0400
Subject: Re: Mouse/Keyboard problems with 2.5.38
From: Stian Jordet <liste@jordet.nu>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021008101711.F4290@ucw.cz>
References: <20020926133725.A8851@ucw.cz>
	<1033054211.587.6.camel@chevrolet> <20020926185717.B27676@ucw.cz>
	<1033080648.593.12.camel@chevrolet> <20020927091040.B1715@ucw.cz>
	<1033127503.589.6.camel@chevrolet> <20021007150052.A1380@ucw.cz>
	<1034020510.1499.8.camel@chevrolet> <20021007220106.A1640@ucw.cz>
	<1034036449.688.8.camel@chevrolet>  <20021008101711.F4290@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 08 Oct 2002 19:18:06 +0200
Message-Id: <1034097546.902.13.camel@chevrolet>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tir, 2002-10-08 kl. 10:17 skrev Vojtech Pavlik:
> On Tue, Oct 08, 2002 at 02:20:49AM +0200, Stian Jordet wrote:
> > man, 2002-10-07 kl. 22:01 skrev Vojtech Pavlik:
> > > On Mon, Oct 07, 2002 at 09:55:10PM +0200, Stian Jordet wrote:
> > [snip]
> > > > I was starting to think you had forgot me :)
> > > 
> > > In that case you should have reminded me of your problem. I tend to
> > > forget when e-mails accumulate beyond a couple hundreds. ;)
> > 
> > I kinda did, in a polite manner. Perhaps I was to polite :)
> > 
> > > > The patch helped a lot. Now it doesn't crash at all. But when I use
> > > > RIGHT-ALT+PAGE-UP, I get these errors a couple of times, then it
> > > > suddenly works as it should.
> > [snip}
> > > I still don't like this behavior - the keyboard shouldn't reinitialize.
> > > Can you repeat the same with I8042_DEBUG_IO?
> > > 
> > > I definitely wasn't able to reproduce this here with very violent
> > > bashing at my keyboard. And l/r alt-pageup works here just fine.
> > 
> > Ok, this is very weird. I tried many times that first boot, and it
> > wouldn't crash what so ever. Ok, it came up with some errors, but I
> > couldn't get it to crash. After a recompile with debug enabled,
> > everything went totally nuts. It didn't crash, but if I pressed S (or
> > what ever key) I would get a screen full of that. Everything was crazy.
> > But still no crash. I rebootet, still same behavior. Then I turned of
> > debugging, and compiled again. And this time it started crashing again
> > (!). I have no idea why, but now it's like it have always been. I have
> > tried several times, used a fresh kerneltree, and patched again, no
> > help. Freezes just like before. I will try some more tomorrow (I'm going
> > to university in five hours), but I really can't understand what have
> > happened. 
> > 
> > Thanks anyway for you work :)
> 
> I really wonder what your keyboard sends for those keys. To avoid the
> freeze (and rescanning of the keyboard), you should be able to
> comment-out these lines in atkbd.c:
> 
>          case ATKBD_KEY_BAT:
>                  serio_rescan(atkbd->serio);
>                  return;
>  
It didn't help at all. I just tried 2.5.41 instead of .40, and now I get
an Oops. Earlier it just froze. Should I write it down?

I'm starting to feel a little embarassed since I'm the only one with
this problem. It's not reallt a big deal, I can boot with i8042_direct,
and it works fine.

Thanks :)

Best regards,
Stian Jordet

