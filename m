Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbTLWU2P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 15:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbTLWU2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 15:28:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:31370 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262355AbTLWU2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 15:28:11 -0500
Date: Tue, 23 Dec 2003 12:27:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Mitchell Blank Jr <mitch@sfgoth.com>,
       "Giacomo A. Catenazzi" <cate@pixelized.ch>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Eric S. Raymond" <esr@thyrsus.com>, Jonathan Magid <jem@ibiblio.org>,
       "H. J. Lu" <hjl@lucon.org>, "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: SCO's infringing files list
In-Reply-To: <20031223190656.GB15049@win.tue.nl>
Message-ID: <Pine.LNX.4.58.0312231221380.14184@home.osdl.org>
References: <200312221519.04677.tcfelker@mtco.com> <Pine.LNX.4.58.0312221337010.6868@home.osdl.org>
 <20031223002641.GD28269@pegasys.ws> <20031223092847.GA3169@deneb.enyo.de>
 <3FE811E3.6010708@debian.org> <Pine.LNX.4.58.0312230317450.12483@home.osdl.org>
 <3FE862E7.1@pixelized.ch> <20031223160425.GB45620@gaz.sfgoth.com>
 <20031223174454.GD45620@gaz.sfgoth.com> <Pine.LNX.4.58.0312230946010.14184@home.osdl.org>
 <20031223190656.GB15049@win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 23 Dec 2003, Andries Brouwer wrote:
> On Tue, Dec 23, 2003 at 09:56:11AM -0800, Linus Torvalds wrote:
> 
> > It's almost certainly the "libc-2.2.2.tar.Z" file that we want
> 
> I just uploaded a copy to
> ftp://ftp.win.tue.nl/pub/linux-local/libc.archive/libc/libc-222.taz

Yup, and I can confirm two things:

 - the strings match 100% (well, duh, we already saw that from the binary)
 - it doesn't even have an "errno.h"

that, together with the timing, pretty much proves that the kernel header
was indeed just auto-generated from sys_errlist[] of that timeframe, with 
a program very much like the one I already posted.

Now, the libc file just says 

	/* This is a list of all known signal numbers.  */

(which is obviously just a cut-and-paste from siglist.c n the same 
directory). But it shouldn't much matter, since I don't think SCO really 
is going to try to claim copyright ownership of the result of standard C 
library interactions like using "sys_errlist[]".

(I take that back - _of_course_ they are going to try to claim ownership. 
After all, they already claimed ownership of code I provably wrote).

			Linus
