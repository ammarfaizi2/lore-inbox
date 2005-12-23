Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030414AbVLWEZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414AbVLWEZz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 23:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbVLWEZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 23:25:55 -0500
Received: from mail.shareable.org ([81.29.64.88]:37000 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S1030411AbVLWEZy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 23:25:54 -0500
Date: Fri, 23 Dec 2005 04:25:00 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Chris Wedgwood <cw@f00f.org>, Diego Calleja <diegocg@gmail.com>,
       jmerkey@wolfmountaingroup.com, mrmacman_g4@mac.com,
       legal@lists.gnumonks.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, garbageout@sbcglobal.net
Subject: Re: blatant GPL violation of ext2 and reiserfs filesystem drivers
Message-ID: <20051223042500.GA4698@mail.shareable.org>
References: <43AACF77.9020206@sbcglobal.net> <496FC071-3999-4E23-B1A2-1503DCAB65C0@mac.com> <1135283241.12761.19.camel@localhost.localdomain> <43AB32C1.1080101@wolfmountaingroup.com> <20051223025638.GA31381@taniwha.stupidest.org> <20051223041522.ac36635d.diegocg@gmail.com> <20051223032809.GA31909@taniwha.stupidest.org> <Pine.LNX.4.58.0512222233430.32123@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0512222233430.32123@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> If I were to receive a binary kernel, that happens to have
> implemented the same API as Linux, is it a violation of the GPL.  As
> long as it doesn't use any of the same code and does a "clean room"
> kind of implementation of the API it is perfectly legal.

Some would say it is not possible to make a "clean room"
implementation of the "Linux kernel API" for modules - especially
modules that need to use symbols marked as "GPLONLY" - because there
isn't a well-documented API, and to define the API you'd have to study
the kernel in such detail that you'd be making a derived work.

(Then again, the same applies to ("not") emulating Windows in WINE...).

There is a de facto understanding, in the form of an uneasy
compromise, that that binary modules which only use standard exported
symbols, not including GPLONLY symbols, are permitted, provided they
are distributed separately from the binary kernel, and loaded at run
time.

But not all kernel copyright holder subscribe to that: some are on
record saying they believe all distributed binary-only modules are
infringing.  So in principle there is no guarantee that distributing
such a binary module is safe from legal consequences, but if you're
into taking business risks based on what most of the relevant people
recommend implicitly or explicitly, then distributing binary modules
which fit the above pattern is what I recommend.  (This is not an
informed legal opinion, and I'm not a lawyer etc.)

Unlike modules, which can do all sorts of dirty things and it's not
really an API, the system call interface is well-documented and
well-defined (and easily emulated), and so using that doesn't imply
making a derived work.  Furthermore, kernel authors have declared
(starting from Linus' preamble to the license) that there should be no
doubt about programs using only the system call interface, so esoteric
legal masturbation does not apply to this anyway.

This sort of thing has been analysed to death a thousand times on
gnu.misc.discuss, and on linux-kernel, in far more detail than will be
done here, so look there to continue the questioning or see where
these questions have lead before.

> So now if I have this binary kernel, and I myself compile a GPL module, I
> don't see anything in the GPL that would prevent me from linking it in.

The GPL does not apply any restrictions to anything about linking.
Only distribution.

> This is where it gets to be a problem with binary modules.  They only
> implement up to the API (granted, it shouldn't include code in the
> headers), but it's the user that's linking and not the distributor.  That
> is where the gray area lies.

It's been discussed to death a thousand times, with reference to other
GPL programs, not just Linux.  Search for "user does the link" or similar.
And "indirect infringement".

-- Jamie
