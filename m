Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265648AbUBPO2X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 09:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265641AbUBPO2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 09:28:23 -0500
Received: from mail.shareable.org ([81.29.64.88]:9604 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S265667AbUBPO2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 09:28:09 -0500
Date: Mon, 16 Feb 2004 14:28:07 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Eduard Bloch <edi@gmx.de>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Message-ID: <20040216142807.GB16658@mail.shareable.org>
References: <20040209115852.GB877@schottelius.org> <200402121655.39709.robin.rosenberg.lists@dewire.com> <20040213003839.GB24981@mail.shareable.org> <200402130216.53434.robin.rosenberg.lists@dewire.com> <20040213022934.GA8858@parcelfarce.linux.theplanet.co.uk> <20040213032305.GH25499@mail.shareable.org> <20040214150934.GA5023@zombie.inka.de> <20040215010150.GA3611@mail.shareable.org> <20040216140338.GA2927@zombie.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040216140338.GA2927@zombie.inka.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eduard Bloch wrote:
> >    I think this is because the character encoding used by the terminal
> >    should be in the TERM environment variable, but it is in LANG instead.
> 
> No. TERM does not have anything to do with locales (LANG).

No.  The locale should not have anything to do with the appropriate
byte sequences need to make the terminal display characters.

It is wrong that LANG must have a different value depending on whether
I log in using a DEC VT100 or a Gnome Terminal, even though I wish to
see exactly the same language, dialect, messages, number formats,
currency formats, dates and times.

It is acceptable that LANG may control the encoding stored in files
and filenames, but this should be independent of the terminal type.

It is especially wrong that libraries which should be
locale-independent - such as curses, slang and readline - must read
the LANG variable in addition to TERM.  If curses does not read and
parse LANG, simple things like the box around a dialog will not line
up correctly.  This is wrong - it is a terminal characteristic.

-- Jamie
