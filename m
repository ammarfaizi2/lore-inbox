Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261792AbSJIOxO>; Wed, 9 Oct 2002 10:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261793AbSJIOxO>; Wed, 9 Oct 2002 10:53:14 -0400
Received: from poup.poupinou.org ([195.101.94.96]:11836 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S261792AbSJIOxL>; Wed, 9 Oct 2002 10:53:11 -0400
Date: Wed, 9 Oct 2002 16:58:50 +0200
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Ducrot Bruno <poup@poupinou.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] I8042_CMD_AUX_TEST oddities for some mouses.
Message-ID: <20021009145850.GA13709@poup.poupinou.org>
References: <20021008144523.GA983@poup.poupinou.org> <20021008180913.A19339@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021008180913.A19339@ucw.cz>
User-Agent: Mutt/1.3.28i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 06:09:13PM +0200, Vojtech Pavlik wrote:
> On Tue, Oct 08, 2002 at 04:45:23PM +0200, Ducrot Bruno wrote:
> 
> > Some aux ports report false values when we send a I8042_CMD_AUX_TEST,
> > which prevent an 'good' probe :(
> > 
> > The values I am aware are 0x01 and PSMOUSE_RET_ACK (taken from FreeBSD).
> > 
> > My own accupoint return 0x02.  I suggest then to do something like
> 
> Do you have any accupoint docs?

No.  Sorry.

This is an accupoint II, with specs only available via a NDA :((
I will be very happy to get them, because this one have 4 buttons,
and 2 of them are 'programable' (as claimed by toshiba),
but I don't know how.


> 
> > attached file (but perhaps with a config, or force option)?
> 
> I guess the only way is to remove the test altogether, as the values are
> defined:
> 
> 00 : OK
> 01 : Clock Error
> 02 : Data Error
> 03 : Clock + Data Error
> fa : Undefined (OK)
> ff : Unknown Error (common => OK)
> 
> Other values don't happen.
> 
> Most controllers return 00. Some ff, some fa. Now if we're going to take
> 01 and 02 as OK as well, then everything is OK and we don't have to test
> at all.

Ok.  Agreed.

I think also that this perticuliar problem occur _only_
with the toshiba satellite 3000-100 and 3000-400 (as reported by FBSD users),
so I guess I have to send a patch for a dmi_scan.c workaround.

Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
