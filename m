Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946249AbWKAAgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946249AbWKAAgJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 19:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946248AbWKAAgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 19:36:09 -0500
Received: from smtp141.iad.emailsrvr.com ([207.97.245.141]:16543 "EHLO
	smtp141.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S1946246AbWKAAgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 19:36:07 -0500
Message-ID: <4547F9C0.4000107@gentoo.org>
Date: Tue, 31 Oct 2006 20:34:56 -0500
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060917)
MIME-Version: 1.0
To: Michael Buesch <mb@bu3sch.de>
CC: Uli Kunitz <kune@deine-taler.de>,
       Johannes Berg <johannes@sipsolutions.net>,
       Holden Karau <holden@pigscanfly.ca>, zd1211-devs@lists.sourceforge.net,
       linville@tuxdriver.com, netdev <netdev@vger.kernel.org>,
       linux-kernel@vger.kernel.org, holdenk@xandros.com
Subject: Re: [PATCH] wireless-2.6 zd1211rw check against regulatory domain
 rather than hardcoded value of 11
References: <f46018bb0610231121s4fb48f88l28a6e7d4f31d40bb@mail.gmail.com> <1162197749.2854.5.camel@ux156> <454683D1.4030200@deine-taler.de> <200611010048.03126.mb@bu3sch.de>
In-Reply-To: <200611010048.03126.mb@bu3sch.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:
> I think the real question is: What does this "band edge" bit actually do?

Not entirely sure, and I don't think we've even seen a device where this 
code path runs (it only runs if a certain bit is set in the EEPROM). 
However, considering that this looks like it plays with some kind of 
radio stuff, and it's simple to implement, it makes sense to at least 
meet the behavior of the vendor driver (as opposed to violating some 
weird regulation somewhere).

> I don't know what channel 1 and 11 have in common.

They are the edges of the channel range in most places.

 > Why don't we set the
> bit for channel 14? Isn't that an "edge", too?

The vendor driver is full of stuff like this, many corners have been 
cut. Chances are that they just wanted to hit the edges in the common 
domain while not breaking things for channel 12~14 users, and didn't go 
the full way of implementing it accurately. I will email the developers 
for clarification.

Daniel
