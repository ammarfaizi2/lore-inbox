Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264264AbTLUX2G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 18:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbTLUX2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 18:28:06 -0500
Received: from zxa8020.lanisdn-gte.net ([206.46.31.146]:32392 "EHLO
	links.magenta.com") by vger.kernel.org with ESMTP id S264264AbTLUX2D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 18:28:03 -0500
Date: Sun, 21 Dec 2003 18:27:57 -0500
From: Raul Miller <moth@magenta.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: user problem with usb duo mouse and keyboard
Message-ID: <20031221182757.F28449@links.magenta.com>
References: <20031221154331.Z28449@links.magenta.com> <20031221213950.GA14664@ucw.cz> <20031221170323.D28449@links.magenta.com> <20031221223443.GA15744@ucw.cz> <20031221175121.E28449@links.magenta.com> <20031221230042.GA15960@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031221230042.GA15960@ucw.cz>; from vojtech@suse.cz on Mon, Dec 22, 2003 at 12:00:42AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 12:00:42AM +0100, Vojtech Pavlik wrote:
> hid-core.c includes hid.h, which in turn, if DEBUG is defined, includes
> hid-debug.h. That last file defines some functions (hid_dump_input,
> hid_dump_device), which are called by hid-core.c.
...
> This is the problem! Don't ever use usbkbd and usbmouse. Use hid
> instead.

Oh!

And, looking at the docs on those modules, I see nice big warnings that
say something similar...

Looking further, these modules where build and installed by default
when I installed my system (debian, with the 2.4.18-bf2.4 kernel), and
I've been carrying forward that configuration on my hand-built kernels,
and never realized I needed to get rid of those modules.

I see the hid-debug messages in syslog now, but the keyboard and mouse
are working properly as well.  Do you want to pursue this any further?
[If so, I can send you the messages.]

[It's perhaps of note that the extra keys on the keyboard are reported
as scancode 0 by showkey (with other release scan codes) when plugged
in via usb and which have different keypress scan codss when plugged as
a ps/2 keyboard.]

[[There's a slight chance that [to avoid confused messages from other
people in my situation] a warning message from hid about usbkbd and
usbmouse would be a good idea.]]

Thank you very much.

Sorry about the confusion,

-- 
Raul Miller
moth@magenta.com
