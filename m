Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267921AbUGaJce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267921AbUGaJce (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 05:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267922AbUGaJce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 05:32:34 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:21638 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S267921AbUGaJcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 05:32:31 -0400
Date: Sat, 31 Jul 2004 11:33:53 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Kristian H??gsberg <krh@bitplanet.net>
Cc: Olav Kongas <olav@enif.ee>, linux-kernel@vger.kernel.org
Subject: Re: input system: EVIOCSABS(abs) ioctl disabled, why?
Message-ID: <20040731093353.GA1579@ucw.cz>
References: <Pine.LNX.4.58.0407281453560.16069@serv.enif.ee> <20040728134313.GB4831@ucw.cz> <410B0486.6060706@bitplanet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410B0486.6060706@bitplanet.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2004 at 04:31:34AM +0200, Kristian H??gsberg wrote:
> Vojtech Pavlik wrote:
> >On Wed, Jul 28, 2004 at 03:41:28PM +0300, Olav Kongas wrote:
> >
> >
> >>When trying to feed calibration information to a touchscreen driver with
> >>the EVIOCSABS(abs) ioctl command, I noticed that this command is disabled
> >>in 2.6.7. Only after the modification given in the patch below it was
> >>possible to use this ioctl command.
> >>
> >>Why is the EVIOCSABS command disabled? I cannot imagine that nobody uses
> >
> >
> >It's a bug. I'll fix it.
> 
> On a related note - shouldn't there also be a EVIOCSLED, or am I missing 
> something obvious?  How do you set keyboard LEDs?
 
You write() an LED event to the device. EVIOCSABS is intended for
modifying the absolute valuator range, not the value itself.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
