Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVAaJJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVAaJJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 04:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbVAaJJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 04:09:29 -0500
Received: from styx.suse.cz ([82.119.242.94]:8865 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261862AbVAaJJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 04:09:26 -0500
Date: Mon, 31 Jan 2005 10:13:03 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/16] New set of input patches
Message-ID: <20050131091303.GA28018@ucw.cz>
References: <200412290217.36282.dtor_core@ameritech.net> <d120d5000501271018358c1d56@mail.gmail.com> <20050127221623.GA2300@ucw.cz> <200501301835.19220.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501301835.19220.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 06:35:18PM -0500, Dmitry Torokhov wrote:

> > You're right. I forgot that serio isn't anymore tied to the driver and
> > can cease to exist on its own asynchronously. However, I'm still not
> > sure whether it's worth it. We might as well simply drop the unregister
> > call in i8042_open for AUX completely and forget about asynchronous
> > unregisters and use normal refcounting. As far as grep knows, it's the
> > only user.
> 
> I am pretty sure I will need asynchronous unregister in some form when
> I finish dynamic protocol switching in psmouse (those darned pass-through
> ports!). Plus again, having these 2 methods will draw driver writers'
> attention to the existence of this particular problem.

OK. I'm convinced.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
