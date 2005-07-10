Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbVGJM0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVGJM0c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 08:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVGJM0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 08:26:32 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:63969 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261923AbVGJM0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 08:26:31 -0400
Date: Sun, 10 Jul 2005 14:26:59 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor@mail.ru>
Cc: alan@redhat.com
Subject: Re: Synaptics Touchpad not detected in 2.6.13-rc2
Message-ID: <20050710122659.GB3174@ucw.cz>
References: <20050708125537.GA4191@inferi.kami.home> <20050708162908.715.qmail@web81301.mail.yahoo.com> <20050709142706.GA4181@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050709142706.GA4181@inferi.kami.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2005 at 04:27:06PM +0200, Mattia Dongili wrote:
> On Fri, Jul 08, 2005 at 09:29:08AM -0700, Dmitry Torokhov wrote:
> [...]
> > Does it help if you boot with "usb-handoff" kernel option? Another
> > one would be "i8042.nomux". Btw, does your laptop have external
> > PS/2 ports?
> 
> Ok, it seems I can now reliably reproduce the wrong detection (by
> removing the power supply before a cold boot) and 'usb-handoff'
> definitely helps.
> 
> Oh, and I don't have any extra ps/2 port available.
 
Since we (SUSE, many thanks to Andi Kleen and Andrea Arcangeli) have
already fixed most of the breakage "usb-handoff" causes on certain
(nvidia, etc) boxes, because of unusual memory layouts and iounmap()
that can't cope with that, I believe it'd be a good idea to enable
"usb-handoff" on vanilla kernels by default as well - SUSE already has
it enabled for more than a year.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
