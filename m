Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266967AbSLKBYF>; Tue, 10 Dec 2002 20:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266968AbSLKBYF>; Tue, 10 Dec 2002 20:24:05 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:31748 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id <S266967AbSLKBYE>;
	Tue, 10 Dec 2002 20:24:04 -0500
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, linuxconsole-dev@lists.sourceforge.net
Subject: Re: 2.5 bk, input driver and dell i8100 nib+pad
References: <m3el9xk7uv.fsf@lugabout.jhcloos.org>
	<m3k7jqj9mi.fsf@lugabout.jhcloos.org>
	<m3n0omk97i.fsf@lugabout.jhcloos.org>
	<11033.1036602261@passion.cambridge.redhat.com>
	<5339.1036653369@passion.cambridge.redhat.com>
	<12249.1036665016@passion.cambridge.redhat.com>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <12249.1036665016@passion.cambridge.redhat.com>
Date: 10 Dec 2002 20:31:38 -0500
Message-ID: <m3isy1mjd1.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "|" == David Woodhouse <dwmw2@infradead.org> writes:

|> Weird. Does it come back to life if you suspend to RAM and resume?
|> Does the 'mouse' get detected as a Synaptics Touchpad by the
|> changed psmouse.c?

I've some more data on this.  I'd had been some time until I was able
to get a 2.5 to boot enough to run X....

Anyway, at 2.5.50 + a few csets, I had a spot where gpm could see the
nib iff /dev/mouse was symlinked to /dev/input/mice (c 13 63) but not
if it was linked to /dev/psaux (c 10 1) as it had been.

I hoped from that that X would also work, but I've not been able to
replicate that success even with gpm.  I don't know what magic insmod
made the difference (I wasn't trying to get it to work at the time,
just accidently hit the nib while at run level 3 and saw the gpm
cursor...).

As for a susend/resume cycle, this box has never been happy to do that.

-JimC

