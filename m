Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266345AbVBDNat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266345AbVBDNat (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 08:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264069AbVBDN0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 08:26:00 -0500
Received: from styx.suse.cz ([82.119.242.94]:10987 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S264841AbVBDNZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 08:25:19 -0500
Date: Fri, 4 Feb 2005 14:25:32 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net
Subject: Re: Touchpad problems with 2.6.11-rc2
Message-ID: <20050204132532.GH10424@ucw.cz>
References: <20050123190109.3d082021@localhost.localdomain> <m3acqr895h.fsf@telia.com> <20050201234148.4d5eac55@localhost.localdomain> <m3lla64r3w.fsf@telia.com> <20050202141117.688c8dd3@localhost.localdomain> <Pine.LNX.4.58.0502022345320.18555@telia.com> <20050203064645.GA2342@ucw.cz> <m31xbxxqac.fsf@telia.com> <20050204061703.GB2329@ucw.cz> <m38y64x1xw.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m38y64x1xw.fsf@telia.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 07:40:43AM +0100, Peter Osterlund wrote:
> Vojtech Pavlik <vojtech@suse.cz> writes:
> 
> > On Thu, Feb 03, 2005 at 10:54:51PM +0100, Peter Osterlund wrote:
> > 
> > > * Removes the xres/yres scaling so that you get the same speed in the
> > >   X and Y directions even if your screen is not square.
> > 
> > The old code assumed that both the pad and the screen are 4:3, not
> > square. It was wrong still.
> 
> alps.c currently contains:
> 
> 	psmouse->dev.evbit[LONG(EV_ABS)] |= BIT(EV_ABS);
> 	input_set_abs_params(&psmouse->dev, ABS_X, 0, 1023, 0, 0);
> 	input_set_abs_params(&psmouse->dev, ABS_Y, 0, 1023, 0, 0);
> 	input_set_abs_params(&psmouse->dev, ABS_PRESSURE, 0, 127, 0, 0);
> 
> Maybe it should set the ABS_Y max value to 767 in that case.

Applied.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
