Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262617AbVDHAob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbVDHAob (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 20:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbVDHAob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 20:44:31 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:28641 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262617AbVDHAoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 20:44:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=eJw/5VS/Lvdet8B+Gzaa6Wlbsu+dEzTxjoZGPas0CN4EVW8k9F+lIargY2dJblIRWUTwGVkxAx3fLohvEoUB3spTh5zYkRiwhg8QmqXbgxZ7gv0PEr3WyFC+DHRIrUsaaaapmyiiwlz9fBgQFOtwrEk4AuiipYxK0xFJLuAnSU8=
Message-ID: <29495f1d05040717445728af5@mail.gmail.com>
Date: Thu, 7 Apr 2005 17:44:23 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Linux 2.6.12-rc2
Cc: Moritz Muehlenhoff <jmm@inutil.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1112913902.9568.304.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0504040945100.32180@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504041430070.2215@ppc970.osdl.org>
	 <E1DJE6t-0001T5-UD@localhost.localdomain>
	 <1112827342.9567.189.camel@gaston>
	 <20050407175026.GA5872@informatik.uni-bremen.de>
	 <29495f1d05040711544695ce89@mail.gmail.com>
	 <1112913902.9568.304.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 7, 2005 3:45 PM, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Thu, 2005-04-07 at 11:54 -0700, Nish Aravamudan wrote:
> > On Apr 7, 2005 10:50 AM, Moritz Muehlenhoff <jmm@inutil.org> wrote:
> > > Benjamin Herrenschmidt wrote:
> > > > > 1. When resuming from S3 suspend and having switched off the backlight
> > > > > with radeontool the backlight isn't switched back on any more.
> > > >
> > > > I'm not sure what's up here, it's a nasty issue with backlight. Can
> > > > radeontool bring it back ?
> > >
> > > Before suspending I power down the backlight with "radeontool light off"
> > > and with 2.6.11 the display is properly restored. With 2.6.12rc2 the
> > > backlight remains switched off and if I switch it on with radeontool it
> > > becomes lighter, but there's still no text from the fbcon, just the blank
> > > screen.
> >
> > FWIW, I have the same problem on a T41p with 2.6.11 and 2.6.12-rc2,
> > except that neither returns from suspend-to-ram with video restored on
> > the LCD. I believe I was able to get video restored on an external CRT
> > in either 2.6.12-rc2 or 2.6.12-rc2-mm1, but the LCD still didn't
> > restore (can verify later today, if you'd like). I had dumped out the
> > radeontool regs values before & after the sleep, in case they help.
> > They are attached.
> >
> > I posted these problems in the "Call for help S3" thread, but no one responded.
> 
> I would say the different value in LVDS_GEN_CNTL explains it. I'll see
> if I can force radeonfb to save/restore this.

Great! That seemed odd to me, as well. I'll be more than happy to try
any patches (I'll take a look at the code tonight myself).

Thanks,
Nish
