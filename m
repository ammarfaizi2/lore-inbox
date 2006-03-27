Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWC0QS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWC0QS4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 11:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbWC0QS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 11:18:56 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:33211 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1750965AbWC0QSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 11:18:55 -0500
Date: Mon, 27 Mar 2006 11:18:45 -0500
To: "Artem B. Bityutskiy" <dedekind@yandex.ru>
Cc: linux@horizon.com, kalin@thinrope.net, linux-kernel@vger.kernel.org
Subject: Re: Lifetime of flash memory
Message-ID: <20060327161845.GA16775@csclub.uwaterloo.ca>
References: <20060326162100.9204.qmail@science.horizon.com> <4426C320.9010002@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4426C320.9010002@yandex.ru>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2006 at 08:36:48PM +0400, Artem B. Bityutskiy wrote:
> I'm actually interested in:
> 
> 1. CF wear-levelling algorithms: how good or bad is it?

Depends on the maker.

> 2. How does CF implement block mapping, does it store the mapping table 
> on-flash or in memory, does it build it by scanning, how scalable are 
> those algorithms.

Well the map has to be stored in flash or other non volatile memory.

> 3. Does CF perform bad erasable blocks hadling transparently when new 
> bad eraseblocks appear.

No idea, but it is almost certainly also vendor specific.

> 4. How tolerant CF to powrer-offs.

I have seen some that a power off in the middle of a write would leave
the card dead (it left it with a partially updated block map).  On
others nothing happened (well you loose the write in progress of course
just as a harddisk would).

> 5. Is there a Garbage Collector in CF and how clever/stupid is it.

That is vendor specific.  Depends how they did it.  Different
generations from a given company may also be different in behaviour.  I
imagine some parts of it are patented by some of the comapnies involed
in flash card making.

> I've heard CF does not have good characteristics in the above mentioned 
> aspects, but still, it would be interesting to know details. I'm not 
> going to use CFs, but as I'm working with flashes, I'm just interested. 
> It'd help me explaining people why it is bad to use CF for more serious 
> applications then those just storing pictures.

The wearleveling is not a part of the CF spec.  So saying anything about
CF in general just doesn't make much sense.  It all depends on the
controller in the CF you are using.

Len Sorensen
