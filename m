Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265818AbUBPTX4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 14:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265791AbUBPTX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 14:23:56 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:30923 "EHLO uni-kl.de")
	by vger.kernel.org with ESMTP id S265876AbUBPTWw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 14:22:52 -0500
Date: Mon, 16 Feb 2004 20:22:28 +0100
From: Eduard Bloch <edi@gmx.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Message-ID: <20040216192228.GC15087@zombie.inka.de>
References: <20040209115852.GB877@schottelius.org> <200402121655.39709.robin.rosenberg.lists@dewire.com> <20040213003839.GB24981@mail.shareable.org> <200402130216.53434.robin.rosenberg.lists@dewire.com> <20040213022934.GA8858@parcelfarce.linux.theplanet.co.uk> <20040213032305.GH25499@mail.shareable.org> <20040214150934.GA5023@zombie.inka.de> <20040215010150.GA3611@mail.shareable.org> <20040216140338.GA2927@zombie.inka.de> <20040216142807.GB16658@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20040216142807.GB16658@mail.shareable.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by mailgate1.uni-kl.de id i1GJMoRL009457
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>
* Jamie Lokier [Mon, Feb 16 2004, 02:28:07PM]:

> > >    I think this is because the character encoding used by the terminal
> > >    should be in the TERM environment variable, but it is in LANG instead.
> > 
> > No. TERM does not have anything to do with locales (LANG).
> 
> No.  The locale should not have anything to do with the appropriate
> byte sequences need to make the terminal display characters.

Heh. It would be very nice if we had the situation that you describe,
but that is actually not the case. TERM specifies the general
capabilities of the terminal. It does _not_ tell the application inside
which FONT encoding is used, nor whether it is compatible with multibyte
input.

> It is wrong that LANG must have a different value depending on whether
> I log in using a DEC VT100 or a Gnome Terminal, even though I wish to
> see exactly the same language, dialect, messages, number formats,
> currency formats, dates and times.

Nonsense, sorry. How should your application know how to encode its
output? How should it know which font is used. I have heard about some
magic strings that application can send to the Xterm (when TERM=xterm)
to tell it to change the font encoding (similar to the string used to
set the window Title used by mc, for example). But this is an extension,
not mandatory for a general implentation of a "terminal".

> It is acceptable that LANG may control the encoding stored in files
> and filenames, but this should be independent of the terminal type.

And what controls the font setting? (see above)

> It is especially wrong that libraries which should be
> locale-independent - such as curses, slang and readline - must read
> the LANG variable in addition to TERM.  If curses does not read and

See above. Especially since different chars are used to draw graphical
characters (lines, boxes, ...), they _must_ know which font encoding
they have to expect.

Regards,
Eduard.
-- 
Zufälle sind die Mittel des Schicksals, durch die es seine wichtigsten
Pläne mit uns durchführt.
		-- Charles Tschopp
