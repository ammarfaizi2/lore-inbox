Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311268AbSCLQ2H>; Tue, 12 Mar 2002 11:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311269AbSCLQ15>; Tue, 12 Mar 2002 11:27:57 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:45828 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S311268AbSCLQ1j>; Tue, 12 Mar 2002 11:27:39 -0500
Date: Tue, 12 Mar 2002 17:27:37 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
Message-ID: <20020312172737.B5026@ucw.cz>
In-Reply-To: <E16kYXz-0001z3-00@the-village.bc.nu> <Pine.LNX.4.33.0203111431340.15427-100000@penguin.transmeta.com> <20020311234553.A3490@ucw.cz> <3C8DDFC8.5080501@evision-ventures.com> <20020312165937.A4987@ucw.cz> <3C8E2A1F.4050607@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C8E2A1F.4050607@evision-ventures.com>; from dalecki@evision-ventures.com on Tue, Mar 12, 2002 at 05:17:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 05:17:35PM +0100, Martin Dalecki wrote:
> Vojtech Pavlik wrote:
> > On Tue, Mar 12, 2002 at 12:00:24PM +0100, Martin Dalecki wrote:
> > 
> > 
> >>Hello Vojtech.
> >>
> >>I have noticed that the ide-timings.h and ide_modules.h are running
> >>much in aprallel in the purpose they serve. Are the any
> >>chances you could dare to care about propagating the
> >>fairly nice ide-timings.h stuff in favour of
> >>ide_modules.h more.
> >>
> >>BTW.> I think some stuff from ide-timings.h just belongs
> >>as generic functions intro ide.c, and right now there is
> >>nobody who you need to work from behind ;-).
> >>
> >>So please feel free to do the changes you apparently desired
> >>to do a long time ago...
> >>
> > 
> > Hmm, ok. Try this. It shouldn't change any functionality, yet makes a
> > small step towards cleaning the chipset specific drivers.
> 
> 
> OK the patch looks fine. Taken. Still I have some notes:
> 
> 1. Let's start calling stuff ATA and not IDE. (AT-Attachment is it
> and not just Integrated Device Electornics.) OK?

Sure. Feel free to rename whatever file/struct/variable you want. In my
opinion, it's just not worth caring about whether we call the stuff ATA
or IDE, both are TLAs with a long history. (Hmm, ATA probably means
Advanced Technology Attachment, right?)

But for new stuff, I'll try to stick with the 'ata' name.

> 2. I quite don't like the nested #include directives in ide-timing.h.
>     It's cleaner to include the needed headers in front of usage
>     of ide-timing.h. (Just s small note.... not really important...)

I can change that, or you can. I think the hdreg.h one is reasonable,
while the ide.h can probably go without any significant trouble. I think
the only file that'll need adding #include <ide.h> will be ide-timing.c

> 3. I wellcome that the MIN MAX macros there are gone. In fact
> I have yerstoday just done basically the same ;-). (Will just have to
> revert it now.
> 
> Patch swallowed.

-- 
Vojtech Pavlik
SuSE Labs
