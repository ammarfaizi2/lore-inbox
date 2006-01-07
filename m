Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWAGQE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWAGQE5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 11:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752556AbWAGQE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 11:04:57 -0500
Received: from smtp114.sbc.mail.re2.yahoo.com ([68.142.229.91]:13711 "HELO
	smtp114.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750786AbWAGQE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 11:04:57 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: request for opinion on synaptics, adb and powerpc
Date: Sat, 7 Jan 2006 11:04:52 -0500
User-Agent: KMail/1.8.3
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Peter Osterlund <petero2@telia.com>,
       Luca Bigliardi <shammash@artha.org>, linux-kernel@vger.kernel.org
References: <20060106231301.GG4732@kamaji.shammash.lan> <1136608396.4840.206.camel@localhost.localdomain> <20060107082523.GA6276@corona.ucw.cz>
In-Reply-To: <20060107082523.GA6276@corona.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601071104.53188.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 January 2006 03:25, Vojtech Pavlik wrote:
> 
> If a relative mode is an absolute must, then a kernel option is IMO
> sufficient (we have psmouse.proto=imps for the classic PS/2 Synaptics
> pads), although a sysfs attribute would likely be better.
> 

Just FYI, writing into /sys/bus/serio/devices/serioX/protcol allows
swicthing ptorocol dynamically (this involves teardown of old input
device and creation of a new one).

> In theory, we could use EV_SYN, SYN_CONFIG for notifying applications
> that the device has changed its capabilities, but a
> disconnect/recreation will work better, since no applications support
> the SYN_CONFIG notification ATM.
> 

I could see SYN_CONFIG being used to signal changes in limits (like min
and max X coordinates) but not to basic device capabilities.

-- 
Dmitry
