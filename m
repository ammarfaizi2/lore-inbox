Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261747AbREURp3>; Mon, 21 May 2001 13:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261791AbREURpT>; Mon, 21 May 2001 13:45:19 -0400
Received: from waste.org ([209.173.204.2]:19988 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S261747AbREURpE>;
	Mon, 21 May 2001 13:45:04 -0400
Date: Mon, 21 May 2001 12:45:41 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Alexander Viro <viro@math.psu.edu>
cc: Abramo Bagnara <abramo@alsa-project.org>,
        Kai Henningsen <kaih@khms.westfalen.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending DeviceNum
In-Reply-To: <Pine.GSO.4.21.0105201034090.8940-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.30.0105211239460.17263-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 May 2001, Alexander Viro wrote:

> On Sun, 20 May 2001, Abramo Bagnara wrote:
>
> > > It may have several. Which one?
> >
> > Can you explain better this?
>
> Example: console. You want to be able to pass font changes. I'm
> less than sure that putting them on the same channel as, e.g.,
> keyboard mapping changes is a good idea.

If you've got side channels that are of a packet nature (aka commands),
then they can all happily coexist on one device. If you've got channels
that are streams or intended for mmap, those ought to be different
devices.

> Moreover, we have channels that are not tied to a particular device -
> they are for a group of them. Example: setting timings for IDE controller.
> Sure, we can just say "open /dev/hda instead of /dev/hda5", but then we
> are back to the "find related file" problem you tried to avoid.

Hmmm.. I suspect there's a permission issue lurking here anyway. It's
probably valid to want to give out raw partition access, say to a
database user, but not to give out permission to fiddle with the
underlying drive.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

