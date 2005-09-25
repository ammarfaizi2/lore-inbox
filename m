Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbVIYUzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbVIYUzi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 16:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbVIYUzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 16:55:38 -0400
Received: from styx.suse.cz ([82.119.242.94]:63700 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932289AbVIYUzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 16:55:37 -0400
Date: Sun, 25 Sep 2005 22:54:55 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Grant Coady <grant_lkml@dodo.com.au>, Simon Evans <spse@secret.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: New inventions in rounding up in catc.c?
Message-ID: <20050925205455.GA6747@midnight.ucw.cz>
References: <200509241343.42464.vda@ilport.com.ua> <l27bj1hjeqsl9ifg4ogb0drj56fsm0j62a@4ax.com> <200509251343.47892.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509251343.47892.vda@ilport.com.ua>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2005 at 01:43:47PM +0300, Denis Vlasenko wrote:
> On Saturday 24 September 2005 21:46, Grant Coady wrote:
> > On Sat, 24 Sep 2005 13:43:42 +0300, Denis Vlasenko <vda@ilport.com.ua> wrote:
> > > 		/* F5U011 only does one packet per RX */
> > > 		if (catc->is_f5u011)
> > > 			break;
> > >-		pkt_start += (((pkt_len + 1) >> 6) + 1) << 6;
> > >+		pkt_start += ((pkt_len + 2) + 63) & ~63;
> > 
> >   		pkt_start += ((pkt_len + 1) + 64) & ~63;
> > 
> > Seems more clear to me.
> 
> Why?
> 
> ((pkt_len + 2) + 63) & ~63 is "add 2 and round up to next 64".
> ((pkt_len + 1) + 64) & ~63 is "???!"
> 
> It's strange code anyway, I hope maintainer can clarify what's going on.
> (I suspect it was intended to be pkt_len - 1, not +, in the first place)
 
Honestly, I don't remember at all. I'll try to find the (very old) docs
I have for the chip.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
