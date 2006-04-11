Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWDKHmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWDKHmu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 03:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWDKHmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 03:42:50 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:59785 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932305AbWDKHmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 03:42:49 -0400
Date: Tue, 11 Apr 2006 09:42:48 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Michael Krufky <mkrufky@m1k.net>
Cc: Greg Stark <gsstark@mit.edu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: pchdtv 3000 cx88 audio very very low level
Message-ID: <20060411074248.GA26518@rhlx01.fht-esslingen.de>
References: <8764lmnlcx.fsf@stark.xeocode.com> <20060407092426.GA21330@rhlx01.fht-esslingen.de> <87d5ftmt5p.fsf@stark.xeocode.com> <20060410133831.GA22079@rhlx01.fht-esslingen.de> <443AF055.9030900@m1k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <443AF055.9030900@m1k.net>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 10, 2006 at 07:55:01PM -0400, Michael Krufky wrote:
> Andreas Mohr wrote:
> >A distant possibility might be that your card is a very specific rare 
> >revision
> >of that thing and thus doesn't have a proper card type entry for it due to
> >almost nobody else having that card.
> >In the TV card area (just as in the WLAN card area) there are quite some 
> >cards
> >sold under the *very same* name but wildly (or not so wildly but 
> >sufficiently)
> >differing hardware (those manufacturer b****rds burn in hell please, 
> >thanks).

> We have recently discovered that the programming for the pcHDTV3000 card 
> was based on a prototype that used the Thomson DTT7610 tuner, and that 
> this particular version of the card has never gone into production.

BINGO!

Do I get to keep the $100000 prize now? :-P

One day you wake up and think by yourself "surely hardware manufacturers
have screwed us enough by now, it cannot happen again" - only for it to *do*
happen again some moments later only...

> The actual version of the card in circulation uses the Thomson DTT7612 
> ...  You do not need a patch to correct this on your machine, at least 
> not for analog NTSC mode.  Just load your driver as follows:
> 
> modprobe cx88xx tuner=60   (it will use tuner 52 by default)
> modprobe cx8800
> 
> Tuner #52 is the previous tuner defined for this card, DTT7610, and 
> tuner #60 is configured for Thomson DTT 7611 7611A 7612 7613 7613A 7614 
> 7615 7615A
> 
> The configuration for this card has been fixed in the v4l-dvb mercurial 
> tree as of this morning.  To update your v4l/dvb modules (so long as you 
> are running kernel 2.6.12 or later) follow the directions here:

Does that mean that detection for this card is now fully automatic and
correct? I'm asking since this is what we should really try to achieve:
99% of people are John Does, and 97% of those would assume Linux support
for this card to be "nonexistent"/"broken" ("thiz Leenux SUCKERZ!"),
and a measly remaining 3% would know how to configure this stuff manually
properly.

Andreas Mohr
(that's the guy that has yet another mis-detected "close but entirely
different" TV card sitting and waiting for its bttv fix soon)
