Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262268AbVDGWsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbVDGWsI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 18:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbVDGWsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 18:48:08 -0400
Received: from gate.crashing.org ([63.228.1.57]:48094 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262268AbVDGWqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 18:46:09 -0400
Subject: Re: Linux 2.6.12-rc2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Moritz Muehlenhoff <jmm@inutil.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <29495f1d05040711544695ce89@mail.gmail.com>
References: <Pine.LNX.4.58.0504040945100.32180@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504041430070.2215@ppc970.osdl.org>
	 <E1DJE6t-0001T5-UD@localhost.localdomain>
	 <1112827342.9567.189.camel@gaston>
	 <20050407175026.GA5872@informatik.uni-bremen.de>
	 <29495f1d05040711544695ce89@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 08 Apr 2005 08:45:02 +1000
Message-Id: <1112913902.9568.304.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-07 at 11:54 -0700, Nish Aravamudan wrote:
> On Apr 7, 2005 10:50 AM, Moritz Muehlenhoff <jmm@inutil.org> wrote:
> > Benjamin Herrenschmidt wrote:
> > > > 1. When resuming from S3 suspend and having switched off the backlight
> > > > with radeontool the backlight isn't switched back on any more.
> > >
> > > I'm not sure what's up here, it's a nasty issue with backlight. Can
> > > radeontool bring it back ?
> > 
> > Before suspending I power down the backlight with "radeontool light off"
> > and with 2.6.11 the display is properly restored. With 2.6.12rc2 the
> > backlight remains switched off and if I switch it on with radeontool it
> > becomes lighter, but there's still no text from the fbcon, just the blank
> > screen.
> 
> FWIW, I have the same problem on a T41p with 2.6.11 and 2.6.12-rc2,
> except that neither returns from suspend-to-ram with video restored on
> the LCD. I believe I was able to get video restored on an external CRT
> in either 2.6.12-rc2 or 2.6.12-rc2-mm1, but the LCD still didn't
> restore (can verify later today, if you'd like). I had dumped out the
> radeontool regs values before & after the sleep, in case they help.
> They are attached.
> 
> I posted these problems in the "Call for help S3" thread, but no one responded.

I would say the different value in LVDS_GEN_CNTL explains it. I'll see
if I can force radeonfb to save/restore this.

Ben.


