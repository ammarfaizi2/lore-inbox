Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265363AbUAJT4P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 14:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265365AbUAJT4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 14:56:15 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:26537 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265363AbUAJTzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 14:55:35 -0500
Date: Sat, 10 Jan 2004 20:55:31 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Do not use synaptics extensions by default
Message-ID: <20040110195531.GD22654@ucw.cz>
References: <20040110175930.GA1749@elf.ucw.cz> <20040110193039.GA22654@ucw.cz> <20040110194420.GA1212@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040110194420.GA1212@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 08:44:20PM +0100, Pavel Machek wrote:

> I'm setting it to PSMOUSE_IMEX, that's just below PSMOUSE_SYNAPTICS:
> 
> #define PSMOUSE_PS2             1
> #define PSMOUSE_PS2PP           2
> #define PSMOUSE_PS2TPP          3
> #define PSMOUSE_GENPS           4
> #define PSMOUSE_IMPS            5
> #define PSMOUSE_IMEX            6
> #define PSMOUSE_SYNAPTICS       7
> 
> That should turn off just synaptics, no? 

No. The numbers are arbitrary.

> Okay, so how to do this properly? Synaptics driver with "mouse
> emulation" is not usable (tap-to-click is critical), and I want to be
> able to boot 2.4...

Well, if you need to boot both 2.6 and 2.4 _and_ need to use gpm and X
in parallel _and_ need tap-to-click in both gpm and X, then you have to
use the kernel command line parameter and put your synaptics into legacy
mode.

Or, the very nice thing to do would be to port the XFree86 driver to
GPM, so that GPM can understand the event protocol as well.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
