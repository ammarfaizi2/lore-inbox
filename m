Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWELUvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWELUvr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 16:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWELUvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 16:51:47 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:8141
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932230AbWELUvq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 16:51:46 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: Linux v2.6.17-rc4
Date: Fri, 12 May 2006 22:58:46 +0200
User-Agent: KMail/1.9.1
References: <Pine.LNX.4.64.0605111640010.3866@g5.osdl.org> <200605121244.22511.mb@bu3sch.de> <20060512114659.GE30285@harddisk-recovery.com>
In-Reply-To: <20060512114659.GE30285@harddisk-recovery.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605122258.46599.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 May 2006 13:47, you wrote:
> On Fri, May 12, 2006 at 12:44:22PM +0200, Michael Buesch wrote:
> > On Friday 12 May 2006 12:24, you wrote:
> > > On Thu, May 11, 2006 at 04:44:03PM -0700, Linus Torvalds wrote:
> > > > Ok, I've let the release time between -rc's slide a bit too much again, 
> > > > but -rc4 is out there, and this is the time to hunker down for 2.6.17.
> > > > 
> > > > If you know of any regressions, please holler now, so that we don't miss 
> > > > them. 
> > > 
> > > I got assertion failures in the bcm43xx driver:
> > > 
> > > bcm43xx: Chip ID 0x4318, rev 0x2
> > 
> > That is expected an non-fatal.
> 
> Assertion failed sounds rather fatal to me.

But it is not fatal. Trust me. I am the author of most of the code.
The worst thing that can happen is that the card does not work.
The best thing that can happen is that it works with some luck.

> > It is no regression.
> 
> It is, I didn't see it in 2.6.17-rc3.

You did not look close enough.

> > We are working on it, but there won't be any fix for 2.6.17, as
> > very intrusive changes are needed to fix this.
> 
> If it's non-fatal, could you remove the assertion, or make it print
> something that sounds less fatal?

Well, the backtrace could be removed.
But I am for not removing the assertions completely, because
this way people don't see what is going on, if the device does not
work.
It is non-fatal in the sense that it does not crash the machine.
It _may_ be fatal, that the device does not work. The
driver is CONFIG_EXPERIMENTAL for some reason.

To say it again: The 4318 is not completely supported, yet.
It may work with some luck, but it is not guaranteed and only
lower bitrates are supported.

-- 
Greetings Michael.
