Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUGIFGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUGIFGg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 01:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbUGIFGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 01:06:36 -0400
Received: from gprs214-56.eurotel.cz ([160.218.214.56]:8577 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264265AbUGIFGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 01:06:33 -0400
Date: Fri, 9 Jul 2004 07:06:18 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] New set of input patches
Message-ID: <20040709050618.GA23152@elf.ucw.cz>
References: <200407080155.07827.dtor_core@ameritech.net> <20040708203200.GA607@openzaurus.ucw.cz> <200407082248.28835.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407082248.28835.dtor_core@ameritech.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > 03-i8042-broken-mux-workaround.patch
> > > 	- Some MUXes get confused what AUX port the byte came from. Assume
> > > 	  that is came from the same port previous byte came from if it
> > > 	  arrived within HZ/10
> > 
> > Does that mean that (even if my hw is ok) when I two mice at once
> > I get random movements?
> 
> No, that code will only kick in if your MUX gets confused and not during
> normal course of operation. Some MUXes, when confused, raise MUXERR flag
> but leave the data byte intact in violation of active multiplexing spec.
> which says that with MUXERR the only valid data bytes are 0xfd, oxfe and
> 0xff (to signal timeout, resend or parity error). So if we get something
> other than 0xfd, 0xfe or 0xff within HZ/10 of last successfully transmitted
> byte we assume that MUX got confused and the byte was sent by the same
> device that transmitted the previous byte.
> 
> Does it make any sense?

Yes... Hmm, it is wonderfull in how many ways hardware can be
broken...

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
