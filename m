Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130472AbQKTAMk>; Sun, 19 Nov 2000 19:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130320AbQKTAMa>; Sun, 19 Nov 2000 19:12:30 -0500
Received: from [213.8.184.104] ([213.8.184.104]:43270 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S130472AbQKTAMW>;
	Sun, 19 Nov 2000 19:12:22 -0500
Date: Mon, 20 Nov 2000 01:38:53 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: Taisuke Yamada <tai@imasy.or.jp>
cc: andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Large "clipped" IDE disk support for 2.4 when using old
 BIOS
In-Reply-To: <200011192311.eAJNBUj02708@research.imasy.or.jp>
Message-ID: <Pine.LNX.4.21.0011200112300.991-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2000, Taisuke Yamada wrote:

> 
> > > > This patch is not good...[snip]
> > >
> > > Please retest with hdc=...
> >
> > Ok, I've booted without the parameter, and without the jumper on
> > clipping mode (I'll do it tommorow, it's 1AM now) got something
> > similiar to what you've written, and everything looks ok.
> 
> Great, so it worked.
> 
> # Since it worked, please discard my message I sent you to wait.
> 
> > Now it reports 90069839 - one sector less. Any damage risk to
> > my filesystems?
> 
> Hmm, that will be trouble if you access that last sector. I'll
> take a look at it after I came back from my work (It's 8AM now
> and got to go to work :-).

Well, I could patch it so it adds that one sector ;-) But that's not the
right way. The true number of sectors is 90069840, since 90069839 doesn't
divide by the number of *real* heads (6) and the number of recording zones
(15). So it needs fixing.

-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
