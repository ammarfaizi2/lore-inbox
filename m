Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311722AbSCNSlR>; Thu, 14 Mar 2002 13:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311724AbSCNSlH>; Thu, 14 Mar 2002 13:41:07 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:8200 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S311722AbSCNSlD>;
	Thu, 14 Mar 2002 13:41:03 -0500
Date: Thu, 14 Mar 2002 19:41:01 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Dave Jones <davej@suse.de>, Martin Dalecki <martin@dalecki.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Actually hide x86 IDE chipsets on !CONFIG_X86
Message-ID: <20020314194101.B15318@ucw.cz>
In-Reply-To: <20020314165018.GE706@opus.bloom.county> <20020314181106.J19636@suse.de> <20020314172402.GG706@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020314172402.GG706@opus.bloom.county>; from trini@kernel.crashing.org on Thu, Mar 14, 2002 at 10:24:02AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 10:24:02AM -0700, Tom Rini wrote:
> On Thu, Mar 14, 2002 at 06:11:06PM +0100, Dave Jones wrote:
> > On Thu, Mar 14, 2002 at 09:50:18AM -0700, Tom Rini wrote:
> >  > Hello.  The following actually hides x86-specific drivers on
> >  > !CONFIG_X86.  The problem is that dep_bool '...' CONFIG_FOO $CONFIG_BAR
> >  > doesn't have the desired effect if CONFIG_BAR isn't set.
> >  > 
> >  > +   if [ "$CONFIG_X86" = "y" ]; then
> >  > +      bool '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640
> >  > +      dep_bool '    CMD640 enhanced support' CONFIG_BLK_DEV_CMD640_ENHANCED $CONFIG_BLK_DEV_CMD640
> >  > +   fi
> > 
> >  I've a PCI card with one of these. It could in theory work on any arch
> >  with a PCI slot.
> 
> A 640 and not a 646?

Yes, exactly. I have one on a card as well.

-- 
Vojtech Pavlik
SuSE Labs
