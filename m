Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290823AbSCOLPo>; Fri, 15 Mar 2002 06:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290277AbSCOLOj>; Fri, 15 Mar 2002 06:14:39 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:5896 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S290796AbSCOLNy>;
	Fri, 15 Mar 2002 06:13:54 -0500
Date: Fri, 15 Mar 2002 12:13:52 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
Message-ID: <20020315121352.A25209@ucw.cz>
In-Reply-To: <20020311234553.A3490@ucw.cz> <3C8DDFC8.5080501@evision-ventures.com> <20020312165937.A4987@ucw.cz> <3C8E28A1.1070902@evision-ventures.com> <20020312172134.A5026@ucw.cz> <3C8E2C2C.2080202@evision-ventures.com> <20020312173301.C5026@ucw.cz> <3C8E3025.4070409@evision-ventures.com> <20020312175044.A5228@ucw.cz> <20020314140210.A37@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020314140210.A37@toy.ucw.cz>; from pavel@suse.cz on Thu, Mar 14, 2002 at 02:02:11PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 02:02:11PM +0000, Pavel Machek wrote:

> > You may happen to have the numbers, though - that should be enough.
> > 
> > Btw, I have a CMD640B based PCI card lying around here, but never
> > managed to get it generate any interrupts, though the rest seems to be
> > working.
> 
> Attach it to the timer interrupt -- that should do it for testing. Simplest
> way is to make ide timeouts HZ/100 and killing "lost interrupt" msg ;-).

Well, it seems like we'll have to something like this anyway. Some chips
sometimes forget to assert the IRQ after a transfer due to HW bugs, and
some PIIX3s are reported to do it quite often.

-- 
Vojtech Pavlik
SuSE Labs
