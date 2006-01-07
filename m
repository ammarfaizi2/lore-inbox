Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030334AbWAGERI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbWAGERI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 23:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030335AbWAGERI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 23:17:08 -0500
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:30852 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030334AbWAGERH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 23:17:07 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: request for opinion on synaptics, adb and powerpc
Date: Fri, 6 Jan 2006 23:17:03 -0500
User-Agent: KMail/1.8.3
Cc: Peter Osterlund <petero2@telia.com>, Luca Bigliardi <shammash@artha.org>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <20060106231301.GG4732@kamaji.shammash.lan> <Pine.LNX.4.58.0601070053470.2702@telia.com> <1136595097.4840.189.camel@localhost.localdomain>
In-Reply-To: <1136595097.4840.189.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601062317.03712.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 January 2006 19:51, Benjamin Herrenschmidt wrote:
> 
> > Fedora handles this situation by always installing the synaptics package
> > and setting up the X config file automatically if the computer has a
> > synaptics touchpad. I guess this approach could work for other
> > distributions too.
> 
> The problem we have is a bit different (or I didn't understand
> something). The mac trackpad has it's own kernel driver and is all
> relative mode. Luca's patch will make it work in absolute mode instead
> for use with X synaptic driver, thus providing more "features" than the
> default relative-mode one.
> 
> So what we are looking for is a way to have the kernel driver switch
> between raw and ps2 modes based on instruction/ioctl from the userland
> client (the X synaptic driver). This shouldn't be much of a problem if
> the X synaptic driver switches it to raw at X start and on EnterVT and
> back to what it was on LeaveVT...
>

Why would you want to switch to relative mode when leaving X? As far as
I know the only other mouse "user" out there is GPM and there are patches
available for it to use event device:

	http://geocities.com/dt_or/gpm/gpm.html

Unfortunately the maintainer can't find time to merge these so they were
sitting there for over 2 years. FWIW Fedora patches their GPM with these.

-- 
Dmitry
