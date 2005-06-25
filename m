Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVFYMs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVFYMs1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 08:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVFYMs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 08:48:27 -0400
Received: from styx.suse.cz ([82.119.242.94]:57767 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261151AbVFYMsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 08:48:23 -0400
Date: Sat, 25 Jun 2005 14:48:18 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Stuart Shelton <stuart@zeus.com>, Daniel Drake <dsd@gentoo.org>,
       Alan Lake <alan.lake@lakeinfoworks.com>, petero2@telia.co.uk
Subject: Re: ALPS touchpad issues still exist in 2.6.12-rc4h
Message-ID: <20050625124818.GA1385@ucw.cz>
References: <42801AEE.5080308@lakeinfoworks.com> <d120d5000505101520ad1761@mail.gmail.com> <1115767038.12779.36.camel@callisto.dnsalias.net> <200505102059.36744.dtor_core@ameritech.net> <Pine.LNX.4.61.0506251431340.3743@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506251431340.3743@scrub.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2005 at 02:34:35PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Tue, 10 May 2005, Dmitry Torokhov wrote:
> 
> > > More than this, with every kernel (at least since the very early 2.4
> > > ones) up to 2.6.10 the ALPS touchpad has worked just fine through
> > > input/mice or the psaux device - why has this changed in 2.6.11,
> > 
> > Because some people do not want tapping and some people do not like
> > default sensitivity and some like having virtual scrolling while other
> > want to have different actions assigned to corner taps.
> 
> I skipped 2.6.11 on my laptop, so I'm only noticing this problem now.
> You didn't really answer the question, why has the _default_ been changed, 
> giving users the possibility to change the defaults is fine, but why is it 
> necessary to break existing setups?
 
Because we added a driver for the pad. There was none before and the pad
had to work in compatibility mode. It seems more beneficial to me to
have the driver enabled by default (saving a lot of #ifdefs) than to
keep perfect compatibility with a no-driver situation.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
