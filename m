Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263019AbTDBOvY>; Wed, 2 Apr 2003 09:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263020AbTDBOvX>; Wed, 2 Apr 2003 09:51:23 -0500
Received: from gw.enyo.de ([212.9.189.178]:30989 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id <S263019AbTDBOvW>;
	Wed, 2 Apr 2003 09:51:22 -0500
To: Kevin Buhr <buhr@telus.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stateless dropping of packets
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: Kevin Buhr <buhr@telus.net>, linux-kernel@vger.kernel.org
Date: Wed, 02 Apr 2003 17:02:45 +0200
In-Reply-To: <87d6k5ltmo.fsf@saurus.asaurus.invalid> (Kevin Buhr's message
 of "01 Apr 2003 14:50:39 -0800")
Message-ID: <87wuidndre.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090017 (Oort Gnus v0.17) Emacs/21.2 (gnu/linux)
References: <87he9ilz05.fsf@deneb.enyo.de>
	<87d6k5ltmo.fsf@saurus.asaurus.invalid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Buhr <buhr@telus.net> writes:

>> Is it possible to drop packets, preferably using 2.4 iptables, before
>> the packet triggers updates of some caches (e.g. the route cache)?
>
> If you DROP the packet in a PREROUTING chain, that should work.  Since
> the "filter" table doesn't have a PREROUTING chain, you need to use a
> table that does, like the "mangle" table.  For example:
>
>         iptables -t mangle -A PREROUTING -s 10.0.0.0/8 -j DROP
>
> should drop everything with a source in 10.0.0.0/8 without touching
> the routing cache.

It does, thanks a lot. *phew* Looks as if I don't have to try some
*BSD instead.

Is this extremely important application of the PREROUTING chain
documented somewhere?  Should I feel embarrassed? 8-)
