Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265357AbUAJUtc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 15:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265368AbUAJUtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 15:49:32 -0500
Received: from zork.zork.net ([64.81.246.102]:21388 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S265357AbUAJUtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 15:49:31 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Do not use synaptics extensions by default
References: <20040110175930.GA1749@elf.ucw.cz> <20040110193039.GA22654@ucw.cz>
	<20040110194420.GA1212@elf.ucw.cz> <20040110195531.GD22654@ucw.cz>
	<6u1xq77e29.fsf@zork.zork.net> <20040110202348.GA23318@ucw.cz>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sat, 10 Jan 2004 20:49:29 +0000
In-Reply-To: <20040110202348.GA23318@ucw.cz> (Vojtech Pavlik's message of
 "Sat, 10 Jan 2004 21:23:48 +0100")
Message-ID: <6uwu7z5y1y.fsf@zork.zork.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> On Sat, Jan 10, 2004 at 08:18:22PM +0000, Sean Neakums wrote:
>
>> > Well, if you need to boot both 2.6 and 2.4 _and_ need to use gpm and X
>> > in parallel _and_ need tap-to-click in both gpm and X, then you have to
>> > use the kernel command line parameter and put your synaptics into legacy
>> > mode.
>> 
>> Using psmouse_proto=imps?  Or something else?
>
> Yes, that one.

I tried 2.6.1 with that option set as above, and also with it set to
base.  In both cases I don't seem to get tap-to-click.  In
2.6.1-rc1-mm1 with psmouse_noext=1, I get tap-to-click.

>> Will this also result in the passthough port not being enabled?
>> (I'd like to disable it.)
>
> It depends on the touchpad firmware. Most leave it enabled.
> In this mode we don't have any control over the passthrough port.

I notice that the passthrough appears as an extra device (mouse1 on my
system).  Is there a way to disable devices from userspace?  I did
find the place in the synaptics driver that looks like it is where the
passthrough port is registered, so I guess I could take that out as a
last resort.  But it's a pain having to remember to patch my kernel
every time I upgrade.

