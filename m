Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318240AbSHSKQn>; Mon, 19 Aug 2002 06:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318250AbSHSKQn>; Mon, 19 Aug 2002 06:16:43 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:12551 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318240AbSHSKQm>; Mon, 19 Aug 2002 06:16:42 -0400
Date: Mon, 19 Aug 2002 12:20:11 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Greg Banks <gnb@alphalink.com.au>
cc: Peter Samuelson <peter@cadcamlab.org>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
In-Reply-To: <3D60BA16.38B9CC40@alphalink.com.au>
Message-ID: <Pine.LNX.4.44.0208191157000.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 19 Aug 2002, Greg Banks wrote:

> Unlike you, I'm not optimistic that a switch to a new language or even a new
> parser for the old language will ever happen.

It would be nice if I could get it into 2.6, but it's not a problem if it
has to wait. I'm currently busy getting menuconfig working again and then
I'm pretty much ready for a beta release.

> In  http://marc.theaimsgroup.com/?l=linux-kernel&m=101387128818052&w=2
> David Woodhouse gives an idea of what would be necessary to get a new
> language+parser accepted.  Can you achieve that yet?

If you compare it to the xconfig output, yes.

> Or you could, today, go build gcml2 from source with "make DEBUG=1" and run

I looked through the list and except from real syntax errors nothing
prevents an automatic conversion.
I have to manually fix things like CONFIG_ALPHA_NONAME, which is first set
by a choice statement and later redefined. My new parser can't deal with
this, because user input is given the highest priority.

bye, Roman

