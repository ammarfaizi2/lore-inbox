Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbUCBNCb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 08:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbUCBNCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 08:02:30 -0500
Received: from styx.suse.cz ([82.208.2.94]:49024 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261635AbUCBNCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 08:02:11 -0500
Date: Tue, 2 Mar 2004 14:02:12 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] New set of input patches
Message-ID: <20040302130212.GA1963@ucw.cz>
References: <200402290153.08798.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402290153.08798.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 29, 2004 at 01:53:58AM -0500, Dmitry Torokhov wrote:

> Here is the new set of input patches that I have. You have seen some of
> them, buit this time they are rediffed against 2.6.4-rc1 and in nice order.

I like them very much. Do you have a bitkeeper tree anywhere where I
could pull from, so that I don't have to apply these by hand?

> 01-atkbd-whitespace-fixes.patch
> 	simple whitespace fixes
> 
> 02-atkbd-bad-merge.patch
> 	clean up bad merge in atkbd module (get rid of MODULE_PARMs,
>         atkbd_softrepeat was declared twice)
> 
> 03-synaptics-relaxed-proto.patch
> 	some hardware (PowerBook) require relaxed Synaptics protocol checks,
>         but relaxed checks hurt hardware implementing proper protocol when
>         device looses sync. With the patch synaptics driver analyzes first
>         full data packet and either staus in relaxed mode or switches into
>         strict mode.
> 
> 04-psmouse-whitespace-fixes.patch
> 	simple whitespace fixes
> 
> 05-psmouse-workaround-noack.patch
> 	some mice do not ACK "disable streaming mode" command causing psmouse
>         driver abort initialization without any indication to the user. This
>         is a regression compared to 2.4. Have kernel complain but continue
>         with prbing hardware (after all we got valid responce from GET ID
> 	command).
> 
> 06-module-param-array-named.patch
> 	introduce module_param_array_named() modeled after module_param_named
> 	that allows mapping array module option to
> 
> 07-joystick-module-param.patch
> 	complete moving input drivers to the new way of handling module
> 	parameters using module_param()
> 
> 08-obsolete-setup.patch
> 	introduce __obsolete_setup(). This is a drop-in replacement for
>         __setup() for truly obsolete options. Kernel will complain when sees
>         such an option.
> 
> 09-input-obsolete-setup.patch
> 	document removed or renamed options in input drivers using
> 	__obsolete_setup() so users will have some clue why old options
>         stopped having any effect.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
