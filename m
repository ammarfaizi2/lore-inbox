Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133022AbRDSTb2>; Thu, 19 Apr 2001 15:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133018AbRDSTbS>; Thu, 19 Apr 2001 15:31:18 -0400
Received: from m646-mp1-cvx1b.col.ntl.com ([213.104.74.134]:17280 "EHLO
	[213.104.74.134]") by vger.kernel.org with ESMTP id <S133009AbRDSTau>;
	Thu, 19 Apr 2001 15:30:50 -0400
To: Patrick Mochel <mochel@transmeta.com>
Cc: "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Next gen PM interface
In-Reply-To: <Pine.LNX.4.10.10104191206100.7690-100000@nobelium.transmeta.com>
From: John Fremlin <chief@bandits.org>
Date: 19 Apr 2001 20:30:41 +0100
In-Reply-To: <Pine.LNX.4.10.10104191206100.7690-100000@nobelium.transmeta.com>
Message-ID: <m2vgo0offi.fsf@bandits.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Solid Vapor)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel <mochel@transmeta.com> writes:

[...]

> > > I can see at least two types of events - (forgive the lack of colorful
> > > terminology) passive and active. Passive events are simply providing
> > > status updates, much like the events described above. These are simply so
> > > some UI can notify the user of things like a low battery or detection of
> > > an AC adapter. These can be handled in much the same way as described
> > > above.
> > 
> > No they can't. They only happen once. Battery status exists all the
> > time.
> 
> Yes they can. My point was they can be handled from userspace in the
> same way that battery status does - by doing a select on a file in
> /proc or /dev. Once in a while (or constantly) they get data from
> the kernel - battery status, AC change, etc - that can be then
> translated and displayed in the UI.

I think these events have a generic utility not specific to UIs. In
particular, when ones battery is running out, one would quite like the
event manager to be notified. As is currently the case with e.g. apmd.

Polling on battery charge left or battery voltage/current is different
from this, surely? Why should such programs have to be notified that
the battery was low? The event itself is pretty useless if you're
doing polling but there is no point throwing it away, in case you
aren't.

[...]

-- 

	http://www.penguinpowered.com/~vii
